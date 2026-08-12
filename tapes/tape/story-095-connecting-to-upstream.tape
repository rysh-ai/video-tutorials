# Story 95: Connecting to Upstream (50s)
# Hook: "Point Rysh at a workspace URL and an API key -- now your session can join the hub."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#
# Run: vhs story-095-connecting-to-upstream.tape

# --- Output Settings ---
Output story-095-connecting-to-upstream.mp4
Output story-095-connecting-to-upstream.gif

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
# "Point Rysh at a workspace URL and an API key --
#  now your session can join the hub."
# ============================================================
Sleep 3.17s

# ============================================================
# 0:03-0:11  Show the upstream config block
# "Upstream lives in your rysh.config under the [upstream]
#  section: enabled, the server url, and your api_key."
# ============================================================
Type "cat rysh.config"
Enter
Sleep 7.27s

# ============================================================
# 0:11-0:19  Launch rysh shared
# "Start rysh with --shared and it auto-shares the first pane
#  to the workspace as soon as it boots."
# ============================================================
Type "rysh --shared"
Enter
Sleep 7.42s

# ============================================================
# 0:19-0:28  Check upstream status
# "Double-Escape into rysh mode. ##upstream status shows your
#  configuration and whether the connection is live."
# ============================================================
Escape
Sleep 0.37s
Escape
Sleep 0.37s
Escape
Sleep 0.37s
Escape
Sleep 1.84s
Type "##upstream status"
Enter
Sleep 4.92s

# ============================================================
# 0:28-0:38  Show my-shares
# "The client connects over NATS-over-WebSocket to rysh-server.
#  ##upstream my-shares lists what this session has published."
# ============================================================
Type "##upstream my-shares"
Enter
Sleep 9.01s

# ============================================================
# 0:38-0:46  Note env overrides
# "Prefer env vars? RYSH_UPSTREAM_ENABLED, RYSH_UPSTREAM_URL, and
#  RYSH_UPSTREAM_API_KEY override the config at launch."
# ============================================================
Type "##share status"
Enter
Sleep 7.34s

# ============================================================
# 0:46-0:50  Hold final frame
# "Config or flags, you're connected to the workspace --
#  ready to share and subscribe."
# ============================================================
Sleep 4.23s
