# Story 98: Workspaces (##ws) (40s)
# Hook: "A workspace is your shared space -- API-key-scoped, and managed right from rysh mode."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - An enabled [upstream] block in rysh.config
#
# Run: vhs story-098-workspaces.tape

# --- Output Settings ---
Output story-098-workspaces.mp4
Output story-098-workspaces.gif

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
# "A workspace is your shared space -- API-key-scoped,
#  and managed right from rysh mode."
# ============================================================
Sleep 1s

# ============================================================
# 0:03-0:09  Launch rysh, enter rysh mode
# "Start rysh and double-Escape into rysh mode. Workspaces are
#  managed with the ##ws command."
# ============================================================
Type "rysh"
Enter
Sleep 3s
Escape
Sleep 0.3s
Escape
Sleep 0.3s
Escape
Sleep 0.3s
Escape
Sleep 1.5s

# ============================================================
# 0:09-0:18  List workspaces
# "##ws list shows the workspaces you can reach. Each API key is
#  scoped to exactly one workspace, so access stays isolated."
# ============================================================
Type "##ws list"
Enter
Sleep 4s

# ============================================================
# 0:18-0:28  Create a workspace
# "##ws create takes a name and an API key, registering a new
#  workspace you can share into."
# ============================================================
Type "##ws create team-rocket sk-ws-abc123"
Enter
Sleep 4s

# ============================================================
# 0:28-0:36  List again to confirm
# "List once more to see it. The new workspace is keyed and
#  ready for shares and subscribers."
# ============================================================
Type "##ws list"
Enter
Sleep 4s

# ============================================================
# 0:36-0:40  Hold final frame
# "One API key, one workspace -- clean boundaries for every
#  team you collaborate with."
# ============================================================
Sleep 3s
