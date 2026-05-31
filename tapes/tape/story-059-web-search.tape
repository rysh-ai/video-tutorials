# Story 59: Web Search (40s)
# Hook: "Ask the agent to search the web -- web_search hits the Brave Search API, no approval needed."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - brave_api_key set in config (or RYSH_BRAVE_API_KEY) to enable web_search
#
# Run: vhs story-059-web-search.tape

# --- Output Settings ---
Output story-059-web-search.mp4
Output story-059-web-search.gif

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
# "Ask the agent to search the web --
#  web_search hits the Brave Search API, no approval needed."
# ============================================================
Sleep 1s

# ============================================================
# 0:03-0:08  Launch rysh
# "Start rysh. Make sure your Brave API key is set so web_search is enabled."
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
# 0:13-0:32  Ask the agent to search
# "Ask it to look something up. The web_search tool queries the Brave Search API
#  and feeds the results back to the agent, which summarizes them right in the pane.
#  It's read-only, so it runs without an approval prompt."
# ============================================================
Type "search the web for the latest Go release version"
Enter
Sleep 11s

# ============================================================
# 0:32-0:37  Narrate the config
# "Web search is off until you set brave_api_key in your config, or the
#  RYSH_BRAVE_API_KEY environment variable -- then every pane can reach the web."
# ============================================================
Sleep 4s

# ============================================================
# 0:37-0:40  Hold final frame
# "The agent's reach extends past your machine -- straight to the web."
# ============================================================
Sleep 3s
