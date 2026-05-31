# Story 60: Web Fetch (40s)
# Hook: "Point the agent at a URL -- web_fetch pulls the page and summarizes it for you."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#
# Run: vhs story-060-web-fetch.tape

# --- Output Settings ---
Output story-060-web-fetch.mp4
Output story-060-web-fetch.gif

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
# "Point the agent at a URL --
#  web_fetch pulls the page and summarizes it for you."
# ============================================================
Sleep 1s

# ============================================================
# 0:03-0:08  Launch rysh
# "Start rysh."
# ============================================================
Type "rysh"
Enter
Sleep 3s

# ============================================================
# 0:08-0:13  Switch to prompt mode
# "Double-press Escape for prompt mode."
# ============================================================
Escape
Sleep 0.3s
Escape
Sleep 2s

# ============================================================
# 0:13-0:32  Ask the agent to fetch a URL
# "Give it a link and ask for a summary. The web_fetch tool pulls the URL's
#  content and hands it to the agent, which reads it and distills the page
#  into a few lines. Fetching is read-only -- no approval prompt."
# ============================================================
Type "fetch https://go.dev and summarize what the page is about"
Enter
Sleep 11s

# ============================================================
# 0:32-0:37  Narrate the pairing
# "Pair web_fetch with web_search and the agent can find a source, open it,
#  and bring the relevant details back into your terminal -- all from one prompt."
# ============================================================
Sleep 4s

# ============================================================
# 0:37-0:40  Hold final frame
# "Any page on the web, summarized in your pane."
# ============================================================
Sleep 3s
