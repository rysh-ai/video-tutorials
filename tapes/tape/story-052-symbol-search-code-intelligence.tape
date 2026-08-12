# Story 52: Symbol Search & Code Intelligence (40s)
# Hook: "Ask where something is defined -- symbol_search and tree map your code instantly."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#
# Run: vhs story-052-symbol-search-code-intelligence.tape

# --- Output Settings ---
Output story-052-symbol-search-code-intelligence.mp4
Output story-052-symbol-search-code-intelligence.gif

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
# "Ask where something is defined --
#  symbol_search and tree map your code instantly."
# ============================================================
Sleep 3.37s

# ============================================================
# 0:03-0:08  Launch rysh
# "Launch rysh inside a codebase you want to understand."
# ============================================================
Type "rysh"
Enter
Sleep 5.25s

# ============================================================
# 0:08-0:13  Switch to prompt mode
# "Double-press Escape to talk to the agent."
# ============================================================
Escape
Sleep 0.71s
Escape
Sleep 4.76s

# ============================================================
# 0:13-0:30  Ask where a function is defined
# "Ask where a function or type lives. The agent uses symbol_search to find
#  declarations -- functions, types, methods -- and tree to show the directory
#  structure around it. Both are read-only, so they run without approval."
# ============================================================
Type "where is the main function defined in this project"
Enter
Sleep 15.29s

# ============================================================
# 0:30-0:37  Narrate the value
# "Instead of grepping by hand, you just ask. Code intelligence tools turn
#  a vague question into a precise file and line, with the surrounding structure."
# ============================================================
Sleep 7.87s

# ============================================================
# 0:37-0:40  Hold final frame
# "Find any declaration, understand any tree -- conversationally."
# ============================================================
Sleep 3.37s
