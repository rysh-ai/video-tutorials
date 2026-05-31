# Story 108: Browser Tools (45s)
# Hook: "Navigate, click, type, screenshot -- the agent's browser toolbelt."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-108-browser-tools.tape

# --- Output Settings ---
Output story-108-browser-tools.mp4
Output story-108-browser-tools.gif

# --- Terminal Settings ---
Set FontSize 16
Set Width 1920
Set Height 1080
Set Theme "Catppuccin Mocha"
Set Padding 20
Set TypingSpeed 75ms
Set Shell "bash"

# ============================================================
# 0:00-0:05  Title / Hook
# "Navigate, click, type, screenshot --
#  the agent's browser toolbelt."
# ============================================================
Sleep 1s

# ============================================================
# 0:05-0:15  browser_action
# "The core tool is browser_action -- it can navigate to a URL, type into a field,
#  or click an element on the page."
# ============================================================
Type "echo 'browser_action: navigate | type | click'"
Enter
Sleep 3s

# ============================================================
# 0:15-0:26  Reading the page
# "To read the page, the agent uses get_text to pull content, and screenshot to
#  capture the view as a base64 image it can reason over."
# ============================================================
Type "echo 'get_text -> page content   |   screenshot -> base64 image'"
Enter
Sleep 3s

# ============================================================
# 0:26-0:36  execute_js and tabs
# "It can run arbitrary page JavaScript with execute_js -- which always requires
#  your approval -- and manage tabs: get_tabs, switch_tab, new_tab, close_tab."
# ============================================================
Type "echo 'execute_js (approval) | tabs: get_tabs / switch_tab / new_tab / close_tab'"
Enter
Sleep 3s

# ============================================================
# 0:36-0:45  Selectors
# "And to find elements reliably, it has six selector strategies to choose from --
#  so it can target the right thing even on messy pages."
# ============================================================
Type "echo '6 selector strategies -> robust element targeting'"
Enter
Sleep 4s
