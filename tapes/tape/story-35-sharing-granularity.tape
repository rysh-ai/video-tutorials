# Story 35: Sharing Granularity (40s)
# Hook: "Share a pane, a group, a lane, or a whole tab -- pick the right scope."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-35-sharing-granularity.tape

# --- Output Settings ---
Output story-35-sharing-granularity.mp4
Output story-35-sharing-granularity.gif

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
# "Start rysh -- sharing works at multiple levels."
# ============================================================
Sleep 1s
Type "rysh"
Enter
Sleep 3s

# ============================================================
# 0:04-0:08  Split right to show multi-pane layout
# "Create a second pane to visualize sharing scopes."
# ============================================================
Ctrl+p
Sleep 0.5s
Type "n"
Sleep 2s

# ============================================================
# 0:08-0:12  Explain sharing levels
# "Rysh lets you share at any level of granularity."
# ============================================================
Type "echo 'Share at any level'"
Enter
Sleep 0.5s

# ============================================================
# 0:12-0:16  Pane level
# "##share pane -- share just one pane."
# ============================================================
Type "echo '##share pane view      - single pane'"
Enter
Sleep 0.5s

# ============================================================
# 0:16-0:20  Pane group level
# "##share panegroup -- share all stacked panes together."
# ============================================================
Type "echo '##share panegroup view - all stacked panes'"
Enter
Sleep 0.5s

# ============================================================
# 0:20-0:24  Lane level
# "##share lane -- share an entire column of panes."
# ============================================================
Type "echo '##share lane view      - entire column'"
Enter
Sleep 0.5s

# ============================================================
# 0:24-0:28  Tab level
# "##share tab -- share the whole tab with all its panes."
# ============================================================
Type "echo '##share tab control    - whole tab'"
Enter
Sleep 0.5s

# ============================================================
# 0:28-0:34  Explain hierarchy
# "Each higher level includes all child panes automatically."
# ============================================================
Type "echo 'Each level includes all child panes'"
Enter
Sleep 2s

# ============================================================
# 0:34-0:40  Hold final frame
# "Pick the scope that fits -- from a single pane to a whole tab."
# ============================================================
Sleep 6s
