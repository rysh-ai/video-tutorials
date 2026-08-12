# Story 31: Stacks & Pane Groups (##new) (40s)
# Hook: "The new command isn't just grids -- it builds any piece of layout."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-031-stacks-pane-groups.tape

# --- Output Settings ---
Output story-031-stacks-pane-groups.mp4
Output story-031-stacks-pane-groups.gif

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
# "The new command isn't just grids --
#  it builds any piece of layout."
# ============================================================
Sleep 3.15s

# ============================================================
# 0:03-0:08  Launch rysh and enter rysh mode
# "Start rysh and cycle into rysh mode
#  with double-Escape."
# ============================================================
Type "rysh"
Enter
Sleep 2.55s
Escape
Sleep 0.26s
Escape
Sleep 0.25s
Escape
Sleep 0.25s
Escape
Sleep 1.27s

# ============================================================
# 0:08-0:16  ##new stack <N>
# "New stack with a count adds that many
#  stacked panes on top of the active group --
#  like dealing cards into a deck."
# ============================================================
Type "##new stack 3"
Enter
Sleep 7.36s

# ============================================================
# 0:16-0:24  ##new pg <N>
# "New pg builds pane groups -- the columns
#  that hold your panes. Pass a count for several at once."
# ============================================================
Type "##new pg 2"
Enter
Sleep 7.59s

# ============================================================
# 0:24-0:32  ##new pane [tab] [lane]
# "New pane adds a single pane, optionally
#  targeting a specific tab and lane."
# ============================================================
Type "##new pane"
Enter
Sleep 7.59s

# ============================================================
# 0:32-0:40  ##new tab
# "And new tab opens a fresh tab.
#  One verb, every structural building block."
# ============================================================
Type "##new tab"
Enter
Sleep 7.66s
