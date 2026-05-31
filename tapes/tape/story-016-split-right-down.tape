# Story 16: Split Right & Split Down (45s)
# Hook: "Build any layout from two moves: split right for columns, split down for rows."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-016-split-right-down.tape

# --- Output Settings ---
Output story-016-split-right-down.mp4
Output story-016-split-right-down.gif

# --- Terminal Settings ---
Set FontSize 16
Set Width 1920
Set Height 1080
Set Theme "Catppuccin Mocha"
Set Padding 20
Set TypingSpeed 75ms
Set Shell "bash"

# ============================================================
# 0:00-0:04  Title / Hook
# "Build any layout from two moves:
#  split right for columns, split down for rows."
# ============================================================
Sleep 1s

# ============================================================
# 0:04-0:09  Launch rysh
# "Start with a single pane in a single column."
# ============================================================
Type "rysh"
Enter
Sleep 3s

# ============================================================
# 0:09-0:16  Ctrl+P n -- first split right
# "Ctrl+P then n splits right. That's a second column,
#  and the space divides between them by flex weight."
# ============================================================
Ctrl+p
Sleep 1s
Type "n"
Sleep 2s

# ============================================================
# 0:16-0:23  Ctrl+P n -- third column
# "Do it again for a third column. Each new pane shares the
#  width evenly -- a clean three-column layout."
# ============================================================
Ctrl+p
Sleep 1s
Type "n"
Sleep 2s

# ============================================================
# 0:23-0:32  Ctrl+P v -- split down in the active column
# "Now press v to split down. The active column gets a second
#  row, stacked vertically inside that same column."
# ============================================================
Ctrl+p
Sleep 1s
Type "v"
Sleep 2s

# ============================================================
# 0:32-0:40  One more split down
# "Split down again and the column packs in another row.
#  Columns grow with n, rows grow with v."
# ============================================================
Ctrl+p
Sleep 1s
Type "v"
Sleep 2s
Escape
Sleep 1s

# ============================================================
# 0:40-0:45  Recap / hold frame
# "Two keys, endless layouts. Flex weights keep everything
#  balanced as you build."
# ============================================================
Sleep 4s
