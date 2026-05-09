# Story 47: Browser Automation (60s)
# Hook: "23 browser actions -- AI controls your browser."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-47-browser-automation.tape

# --- Output Settings ---
Output story-47-browser-automation.mp4
Output story-47-browser-automation.gif

# --- Terminal Settings ---
Set FontSize 16
Set Width 1920
Set Height 1080
Set Theme "Catppuccin Mocha"
Set FontFamily "JetBrainsMono Nerd Font Mono"
Set Padding 20
Set TypingSpeed 75ms
Set Shell "bash"

# ============================================================
# 0:00-0:04  Launch rysh
# "Start rysh -- browser automation with AI."
# ============================================================
Sleep 1s
Type "rysh"
Enter
Sleep 3s

# ============================================================
# 0:04-0:07  Title
# "Browser Automation -- AI controls your browser."
# ============================================================
Type "echo 'Browser Automation - AI Controls Your Browser'"
Enter
Sleep 0.5s

# ============================================================
# 0:07-0:09  Blank line
# ============================================================
Type "echo ''"
Enter
Sleep 0.2s

# ============================================================
# 0:09-0:13  Action count
# "23 browser actions via the browser_action tool."
# ============================================================
Type "echo '23 browser actions via browser_action tool:'"
Enter
Sleep 0.5s

# ============================================================
# 0:13-0:17  Navigation actions
# "navigate, click, type, get_text, screenshot."
# ============================================================
Type "echo '  navigate, click, type, get_text, screenshot'"
Enter
Sleep 0.5s

# ============================================================
# 0:17-0:21  Tab actions
# "get_tabs, switch_tab, new_tab, close_tab."
# ============================================================
Type "echo '  get_tabs, switch_tab, new_tab, close_tab'"
Enter
Sleep 0.5s

# ============================================================
# 0:21-0:25  Other actions
# "scroll, wait, execute_js (requires approval)."
# ============================================================
Type "echo '  scroll, wait, execute_js (requires approval)'"
Enter
Sleep 0.5s

# ============================================================
# 0:25-0:27  Blank line
# ============================================================
Type "echo ''"
Enter
Sleep 0.2s

# ============================================================
# 0:27-0:31  Selectors header
# "Multiple element selection strategies."
# ============================================================
Type "echo 'Element selection strategies:'"
Enter
Sleep 0.5s

# ============================================================
# 0:31-0:35  Selector types
# "CSS, XPath, text, aria, role, testid selectors."
# ============================================================
Type "echo '  CSS, XPath, text:, aria:, role:, testid:'"
Enter
Sleep 0.5s

# ============================================================
# 0:35-0:37  Blank line
# ============================================================
Type "echo ''"
Enter
Sleep 0.2s

# ============================================================
# 0:37-0:42  Example prompt
# "Natural language to browser actions."
# ============================================================
Type "echo 'Example: 'Go to GitHub and search for rysh''"
Enter
Sleep 0.5s

# ============================================================
# 0:42-0:48  Example flow
# "The AI chains: navigate -> type -> click -> get_text."
# ============================================================
Type "echo '  -> navigate -> type -> click -> get_text'"
Enter
Sleep 2s

# ============================================================
# 0:48-0:60  Hold final frame
# "Browser automation -- natural language to browser actions."
# ============================================================
Sleep 12s
