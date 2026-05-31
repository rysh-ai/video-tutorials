# Story 12: Jump & Rename Tabs (40s)
# Hook: "Jump to any tab by number, and give your tabs real names."
#
# Run: vhs story-012-jump-and-rename-tabs.tape

# --- Output Settings ---
Output story-012-jump-and-rename-tabs.mp4
Output story-012-jump-and-rename-tabs.gif

# --- Terminal Settings ---
Set FontSize 16
Set Width 1920
Set Height 1080
Set Theme "Catppuccin Mocha"
Set Padding 20
Set TypingSpeed 75ms
Set Shell "bash"

Sleep 1s

# ============================================================
# 0:00-0:04  Title / Hook
# "Jump to any tab by number, and give your tabs
#  real, memorable names."
# ============================================================
Sleep 2s

Type "rysh"
Enter
Sleep 3s

# Build a few tabs to work with
Ctrl+t
Sleep 1s
Type "n"
Sleep 1s
Type "n"
Sleep 1s
Type "n"
Sleep 1.5s

# ============================================================
# 0:04-0:16  Jump by index
# "In tab mode, the number keys 1 through 9 jump
#  directly to a tab by its index."
# ============================================================
Type "1"
Sleep 1.5s
Type "4"
Sleep 1.5s
Type "2"
Sleep 1.5s
Escape
Sleep 1s

# ============================================================
# 0:16-0:28  Rename the active tab
# "Switch to rysh mode and name the active tab with
#  ##tab name. Here we call it backend."
# ============================================================
Escape
Sleep 0.3s
Escape
Sleep 0.3s
Escape
Sleep 1s
Type "##tab name backend"
Sleep 2s
Enter
Sleep 3s

# ============================================================
# 0:28-0:40  Rename a tab by id
# "Add a tab ID before the name to rename any tab,
#  not just the active one -- ##tab name, id, then name."
# ============================================================
Type "##tab name 2 frontend"
Sleep 2s
Enter
Sleep 4s
