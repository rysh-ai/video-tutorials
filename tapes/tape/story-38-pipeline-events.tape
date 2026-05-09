# Story 38: Pipeline Events (45s)
# Hook: "Broadcast events across panes -- pipelines start with print events."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-38-pipeline-events.tape

# --- Output Settings ---
Output story-38-pipeline-events.mp4
Output story-38-pipeline-events.gif

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
# "Start rysh -- events flow between panes."
# ============================================================
Sleep 1s
Type "rysh"
Enter
Sleep 3s

# ============================================================
# 0:04-0:08  Name this pane "orchestrator"
# "Name this pane so listeners can subscribe to it."
# ============================================================
Type "##pane name orchestrator"
Enter
Sleep 1s

# ============================================================
# 0:08-0:14  Split right and listen
# "Create a listener pane that watches the orchestrator."
# ============================================================
Ctrl+p
Sleep 0.5s
Type "n"
Sleep 2s
Type "##pane listen orchestrator"
Enter
Sleep 1s

# ============================================================
# 0:14-0:18  Tab back to orchestrator
# "Switch back to the orchestrator to emit events."
# ============================================================
Tab
Sleep 1s

# ============================================================
# 0:18-0:24  Emit first event
# "##>event:print broadcasts a text event to all listeners.
#  The listener pane shows it in real time."
# ============================================================
Type "##>event:print:Build started at 10:30 AM"
Enter
Sleep 2s

# ============================================================
# 0:24-0:30  Emit second event
# "Each event streams to every pane listening to orchestrator."
# ============================================================
Type "##>event:print:Compiling modules..."
Enter
Sleep 2s

# ============================================================
# 0:30-0:36  Emit third event
# "Events form the building blocks of pipelines."
# ============================================================
Type "##>event:print:Build complete!"
Enter
Sleep 2s

# ============================================================
# 0:36-0:45  Hold final frame
# "Pipeline events -- the foundation for multi-pane workflows."
# ============================================================
Sleep 9s
