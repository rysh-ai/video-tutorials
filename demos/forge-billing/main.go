// forge-billing: tiny mock "internal billing API" for the ad04 Forge demo.
//
// Go stdlib only — no dependencies. All data is obviously fake (Acme/test values).
//
// Run:  go run .                 (listens on :8099)
//       BILLING_ADDR=:9100 go run .
//
// Endpoints (see billing-openapi.yaml):
//   GET    /health                     — liveness probe
//   GET    /invoices?status=unpaid     — list invoices (optional status filter)
//   GET    /invoices/{id}              — one invoice
//   GET    /invoices/summary           — count + total, optional ?status=
//   DELETE /invoices/{id}              — void an invoice (MUTATING — demo default-deny)
package main

import (
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"os"
	"strings"
	"sync"
)

type Invoice struct {
	ID       string  `json:"id"`
	Customer string  `json:"customer"`
	AmountUSD float64 `json:"amount_usd"`
	Status   string  `json:"status"` // unpaid | paid | void
	IssuedAt string  `json:"issued_at"`
	DueAt    string  `json:"due_at"`
}

var (
	mu       sync.RWMutex
	invoices = []Invoice{
		{ID: "INV-2026-0001", Customer: "Acme Rockets Ltd", AmountUSD: 1250.00, Status: "paid", IssuedAt: "2026-07-01", DueAt: "2026-07-15"},
		{ID: "INV-2026-0002", Customer: "Globex Test Corp", AmountUSD: 480.50, Status: "unpaid", IssuedAt: "2026-07-03", DueAt: "2026-07-17"},
		{ID: "INV-2026-0003", Customer: "Initech Demo GmbH", AmountUSD: 2999.99, Status: "unpaid", IssuedAt: "2026-07-05", DueAt: "2026-07-19"},
		{ID: "INV-2026-0004", Customer: "Acme Rockets Ltd", AmountUSD: 320.00, Status: "unpaid", IssuedAt: "2026-07-08", DueAt: "2026-07-22"},
		{ID: "INV-2026-0005", Customer: "Wayne Sandbox Inc", AmountUSD: 799.00, Status: "paid", IssuedAt: "2026-07-10", DueAt: "2026-07-24"},
	}
)

func writeJSON(w http.ResponseWriter, code int, v any) {
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(code)
	enc := json.NewEncoder(w)
	enc.SetIndent("", "  ")
	_ = enc.Encode(v)
}

func errJSON(w http.ResponseWriter, code int, msg string) {
	writeJSON(w, code, map[string]string{"error": msg})
}

func main() {
	addr := os.Getenv("BILLING_ADDR")
	if addr == "" {
		addr = "127.0.0.1:8099" // loopback only — never exposed beyond this machine
	}

	mux := http.NewServeMux()

	mux.HandleFunc("/health", func(w http.ResponseWriter, r *http.Request) {
		log.Printf("%s %s", r.Method, r.URL.Path)
		writeJSON(w, 200, map[string]string{"status": "ok", "service": "acme-billing (mock)"})
	})

	mux.HandleFunc("/invoices", func(w http.ResponseWriter, r *http.Request) {
		log.Printf("%s %s?%s", r.Method, r.URL.Path, r.URL.RawQuery)
		if r.Method != http.MethodGet {
			errJSON(w, 405, "method not allowed")
			return
		}
		status := strings.ToLower(r.URL.Query().Get("status"))
		mu.RLock()
		defer mu.RUnlock()
		out := []Invoice{}
		for _, inv := range invoices {
			if status == "" || inv.Status == status {
				out = append(out, inv)
			}
		}
		writeJSON(w, 200, map[string]any{"invoices": out, "count": len(out)})
	})

	mux.HandleFunc("/invoices/summary", func(w http.ResponseWriter, r *http.Request) {
		log.Printf("%s %s?%s", r.Method, r.URL.Path, r.URL.RawQuery)
		if r.Method != http.MethodGet {
			errJSON(w, 405, "method not allowed")
			return
		}
		status := strings.ToLower(r.URL.Query().Get("status"))
		mu.RLock()
		defer mu.RUnlock()
		var total float64
		count := 0
		for _, inv := range invoices {
			if status == "" || inv.Status == status {
				total += inv.AmountUSD
				count++
			}
		}
		writeJSON(w, 200, map[string]any{
			"status_filter": status, "count": count, "total_usd": fmt.Sprintf("%.2f", total),
		})
	})

	mux.HandleFunc("/invoices/", func(w http.ResponseWriter, r *http.Request) {
		id := strings.TrimPrefix(r.URL.Path, "/invoices/")
		log.Printf("%s %s", r.Method, r.URL.Path)
		if id == "" || strings.Contains(id, "/") {
			errJSON(w, 404, "not found")
			return
		}
		switch r.Method {
		case http.MethodGet:
			mu.RLock()
			defer mu.RUnlock()
			for _, inv := range invoices {
				if inv.ID == id {
					writeJSON(w, 200, inv)
					return
				}
			}
			errJSON(w, 404, "invoice not found: "+id)
		case http.MethodDelete: // MUTATING — the default-deny demo beat
			mu.Lock()
			defer mu.Unlock()
			for i, inv := range invoices {
				if inv.ID == id {
					invoices[i].Status = "void"
					log.Printf("!! MUTATION: voided %s", id)
					writeJSON(w, 200, map[string]string{"voided": id})
					return
				}
			}
			errJSON(w, 404, "invoice not found: "+id)
		default:
			errJSON(w, 405, "method not allowed")
		}
	})

	log.Printf("acme-billing (mock) listening on %s — dummy data only", addr)
	log.Fatal(http.ListenAndServe(addr, mux))
}
