# Story 55: Running Tests (45s)
# Hook: "Run the tests and fix the failures -- test_run gives structured pass/fail the agent can act on."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Run inside a project with tests
#
# Run: vhs story-055-running-tests.tape

# --- Output Settings ---
Output story-055-running-tests.mp4
Output story-055-running-tests.gif

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
# "Run the tests and fix the failures --
#  test_run gives structured pass/fail the agent can act on."
# ============================================================
Sleep 1s

# ============================================================
# 0:03-0:08  Launch rysh
# "Start rysh inside a project that has a test suite."
# ============================================================
Type "rysh"
Enter
Sleep 3s

# ============================================================
# 0:08-0:13  Switch to prompt mode
# "Double-press Escape to enter prompt mode."
# ============================================================
Escape
Sleep 0.3s
Escape
Sleep 2s

# ============================================================
# 0:13-0:32  Ask the agent to run tests and fix
# "Ask it to run the tests and fix what fails. The test_run tool executes your
#  suite and returns structured results -- which tests passed, which failed, and
#  why. No approval needed to run them; the agent reads the failures directly."
# ============================================================
Type "run the tests and fix any failures"
Enter
Sleep 11s

# ============================================================
# 0:32-0:42  Narrate the fix loop
# "When the agent proposes a fix, the file edit is approval-gated -- you see the
#  diff, approve it, and it reruns the suite to confirm everything's green."
# ============================================================
Sleep 4s

# ============================================================
# 0:42-0:45  Hold final frame
# "Structured test results in, fixes out -- one prompt at a time."
# ============================================================
Sleep 3s
