# Story 49: Stripe Billing (45s)
# Hook: "Subscription billing with Stripe -- four tiers, enforced at every layer."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-49-stripe-billing.tape

# --- Output Settings ---
Output story-49-stripe-billing.mp4
Output story-49-stripe-billing.gif

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
# "Start rysh -- Stripe billing integration."
# ============================================================
Sleep 1s
Type "rysh"
Enter
Sleep 3s

# ============================================================
# 0:04-0:07  Title
# "Subscription Billing with Stripe."
# ============================================================
Type "echo 'Subscription Billing with Stripe'"
Enter
Sleep 0.5s

# ============================================================
# 0:07-0:09  Blank line
# ============================================================
Type "echo ''"
Enter
Sleep 0.2s

# ============================================================
# 0:09-0:12  Tiers header
# "Four subscription tiers."
# ============================================================
Type "echo 'Tiers:'"
Enter
Sleep 0.5s

# ============================================================
# 0:12-0:16  Free tier
# "Free: 1 workspace, 3 sessions, 30 panes."
# ============================================================
Type "echo '  Free:       1 ws,  3 sess,   30 panes   \\$0/mo'"
Enter
Sleep 0.5s

# ============================================================
# 0:16-0:20  Solo tier
# "Solo: 3 workspaces, 10 sessions, 100 panes at $19/mo."
# ============================================================
Type "echo '  Solo:       3 ws, 10 sess,  100 panes  \\$19/mo'"
Enter
Sleep 0.5s

# ============================================================
# 0:20-0:24  Team tier
# "Team: 20 workspaces, 200 sessions, 2000 panes at $49/mo."
# ============================================================
Type "echo '  Team:      20 ws, 200 sess, 2000 panes  \\$49/mo'"
Enter
Sleep 0.5s

# ============================================================
# 0:24-0:28  Enterprise tier
# "Enterprise: unlimited, custom pricing."
# ============================================================
Type "echo '  Enterprise: unlimited              custom'"
Enter
Sleep 1s

# ============================================================
# 0:28-0:30  Blank line
# ============================================================
Type "echo ''"
Enter
Sleep 0.2s

# ============================================================
# 0:30-0:35  Enforcement
# "Limits enforced at each layer."
# ============================================================
Type "echo 'Enforcement: Workspaces(server) Sessions(WS) Panes(daemon)'"
Enter
Sleep 0.5s

# ============================================================
# 0:35-0:40  Stripe features
# "Stripe Checkout, Billing Portal, and Webhooks."
# ============================================================
Type "echo 'Stripe Checkout + Billing Portal + Webhooks'"
Enter
Sleep 2s

# ============================================================
# 0:40-0:45  Hold final frame
# "Stripe billing -- four tiers, enforced everywhere."
# ============================================================
Sleep 5s
