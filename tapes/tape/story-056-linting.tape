# Story 56: Linting (40s)
# Hook: "Lint and fix -- the agent runs go vet, staticcheck, and golangci-lint, then cleans up."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Run inside a Go project
#
# Run: vhs story-056-linting.tape

# --- Output Settings ---
Output story-056-linting.mp4
Output story-056-linting.gif

# --- Terminal Settings ---
Set FontSize 16
Set Width 1920
Set Height 1080
Set Theme "Catppuccin Mocha"
Set Padding 20
Set TypingSpeed 75ms
Set Shell "bash"

# ============================================================
# 0:00-0:03  Title / Hook
# "Lint and fix -- the agent runs go vet, staticcheck, and golangci-lint,
#  then cleans up."
# ============================================================
Sleep 3.38s

# ============================================================
# 0:03-0:08  Launch rysh
# "Launch rysh inside your project."
# ============================================================
Type "rysh"
Enter
Sleep 5.26s

# ============================================================
# 0:08-0:13  Switch to prompt mode
# "Double-press Escape for prompt mode."
# ============================================================
Escape
Sleep 0.72s
Escape
Sleep 4.77s

# ============================================================
# 0:13-0:30  Ask the agent to lint and fix
# "Ask it to lint and fix. The lint tool runs the standard Go linters --
#  go vet, staticcheck, and golangci-lint -- and returns each finding.
#  Running the linters needs no approval; the agent reads the warnings straight back."
# ============================================================
Type "lint this project and fix the warnings"
Enter
Sleep 16.25s

# ============================================================
# 0:30-0:37  Narrate the fix step
# "As with build and test, the actual code fixes are approval-gated --
#  you review the diff before any change is written, then it re-lints to verify."
# ============================================================
Sleep 7.89s

# ============================================================
# 0:37-0:40  Hold final frame
# "Clean code, on request -- linters run, fixes reviewed."
# ============================================================
Sleep 3.38s
