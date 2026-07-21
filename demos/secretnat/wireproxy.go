// wireproxy is the on-camera "wire proof" for the SecretNAT demo (ad11).
//
// It is a transparent reverse proxy in front of api.anthropic.com that tees
// every REQUEST body into wire.log before forwarding — so the demo can grep
// the actual bytes that left the machine and show that the outbound
// conversation carries only synthetic SNAT tokens, never the real secret.
// Responses (including SSE streams) pass through untouched with immediate
// flushing, so the live agent run through the proxy is a completely real run.
//
// Usage:
//
//	go run wireproxy.go                # listens on 127.0.0.1:8899, logs to ./wire.log
//	RYSH_API_URL=http://127.0.0.1:8899 rysh …
//
// Then on camera:
//
//	grep -c  'sk_live_demo'         wire.log   # → 0  (real key never left)
//	grep -oh 'sk_live_SNAT[0-9]*'   wire.log | sort -u   # → the synthetic token
package main

import (
	"fmt"
	"io"
	"log"
	"net/http"
	"net/http/httputil"
	"net/url"
	"os"
	"sync"
)

func main() {
	listen := "127.0.0.1:8899"
	logPath := "wire.log"
	if len(os.Args) > 1 {
		logPath = os.Args[1]
	}

	upstream, _ := url.Parse("https://api.anthropic.com")
	logFile, err := os.OpenFile(logPath, os.O_CREATE|os.O_WRONLY|os.O_APPEND, 0o644)
	if err != nil {
		log.Fatal(err)
	}
	var mu sync.Mutex

	proxy := httputil.NewSingleHostReverseProxy(upstream)
	proxy.FlushInterval = -1 // flush immediately: SSE streaming must pass through live
	director := proxy.Director
	proxy.Director = func(r *http.Request) {
		director(r)
		r.Host = upstream.Host
	}

	handler := http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		log.Printf("REQ %s %s", r.Method, r.URL.Path)
		if r.Body != nil {
			body, err := io.ReadAll(r.Body)
			if err == nil {
				mu.Lock()
				fmt.Fprintf(logFile, "=== %s %s ===\n%s\n\n", r.Method, r.URL.Path, body)
				logFile.Sync()
				mu.Unlock()
				r.Body = io.NopCloser(newReader(body))
				r.ContentLength = int64(len(body))
			}
		}
		proxy.ServeHTTP(w, r)
	})

	log.Printf("wireproxy: %s -> %s, request bodies tee'd to %s", listen, upstream, logPath)
	log.Fatal(http.ListenAndServe(listen, handler))
}

type byteReader struct {
	b []byte
	i int
}

func newReader(b []byte) *byteReader { return &byteReader{b: b} }

func (r *byteReader) Read(p []byte) (int, error) {
	if r.i >= len(r.b) {
		return 0, io.EOF
	}
	n := copy(p, r.b[r.i:])
	r.i += n
	return n, nil
}
