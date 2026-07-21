# Story AD-04 (OWNER side): Forge private-API tunneling — "Your API. Their agent. Never public."
# Master plan: marketing/assets/videos/forge-private-api.md
# Demo prompt: DEMO-PROMPT-forge-video.md
#
# Run via: video-tutorials/tapes/render-ad04.sh  (handles session hygiene,
#          billing service, daemon pre-create with RYSH_GROUNDING=off, and the
#          background team-driver that fires the remote agent call during the
#          tail -f proof window).
#
# All commands verified against build v0.1.25-90-g8b75c48 on 2026-07-15
# (headless off-camera run; see forge-private-api.md QC notes).

# --- Output Settings ---
Output story-ad04-forge-owner.mp4

# --- Terminal Settings ---
Set FontSize 16
Set Width 1920
Set Height 1080
Set Theme "Catppuccin Mocha"
Set Padding 60
Set TypingSpeed 75ms
Set Shell "bash"

Sleep 1s

# ============================================================
# 0:00-0:12  Hook (title card added in post)
# "Your internal API runs on localhost, behind the firewall --
#  where it belongs. Now your teammate's agent needs it. The
#  usual answer: expose it, tunnel it, or paste keys around.
#  Here's a fourth answer."
# ============================================================
Type "curl -s localhost:8099/health"
Enter
Sleep 3s
Type "rysh attach story-ad04-owner"
Enter
Sleep 6s
# focus insurance (activePane race — ad10 master plan §5)
Ctrl+Space
Sleep 1s
Right
Sleep 1s
Escape
Sleep 1s

# ============================================================
# 0:12-0:30  Forge it
# "Point Forge at the OpenAPI spec. It generates the whole
#  integration surface: agent tools, an MCP server, SDKs in
#  four languages, docs. One command."
# ============================================================
Type@40ms "##forge add billing ./billing-openapi.yaml --targets rysh-toolpack,docs,mcp-server,go-sdk,ts-sdk,py-sdk"
Enter
Sleep 9s

# ============================================================
# 0:30-0:48  Enable it, share it upstream
# "Enable it -- five operations become agent tools. Share it
#  through the rysh upstream. Note what did NOT happen: no
#  port opened, no gateway deployed, no API key mailed around.
#  And the policy line says it out loud: mutating operations
#  are denied unless the owner allows them."
# ============================================================
Type "##integration enable billing"
Enter
Sleep 5s
Type "##forge share api billing"
Enter
Sleep 6s
Type "##forge shares"
Enter
Sleep 7s

# ============================================================
# 0:48-1:50  The wire (proof frame -- teammate's agent calls in)
# "Watch the owner's machine. A teammate's agent -- another
#  session, another terminal -- is calling this API right now.
#  Only the operation name and arguments travel over the
#  upstream. The HTTP call executes here, inside the firewall,
#  and the response goes back. The API never left this box."
# ============================================================
Type "tail -f billing.log"
Enter
Sleep 62s
Ctrl+C
Sleep 2s

# ============================================================
# 1:50-2:00  Never exposed
# "And the API itself? Loopback only. No public listener. It
#  was never on the internet -- not for a second."
# ============================================================
Type "lsof -nP -i :8099 | grep LISTEN"
Enter
Sleep 7s

# ============================================================
# 2:00-2:05  Detach (end card added in post)
# ============================================================
Ctrl+O
Sleep 1s
Type "d"
Sleep 3s
