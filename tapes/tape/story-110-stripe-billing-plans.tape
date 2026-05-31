# Story 110: Stripe Billing & Plans (50s)
# Hook: "Four tiers, Stripe checkout, and limits enforced in three places."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - No existing default session (run: rysh delete-session default)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-110-stripe-billing-plans.tape

# --- Output Settings ---
Output story-110-stripe-billing-plans.mp4
Output story-110-stripe-billing-plans.gif

# --- Terminal Settings ---
Set FontSize 16
Set Width 1920
Set Height 1080
Set Theme "Catppuccin Mocha"
Set Padding 20
Set TypingSpeed 75ms
Set Shell "bash"

# ============================================================
# 0:00-0:05  Title / Hook
# "Four tiers, Stripe checkout,
#  and limits enforced in three places."
# ============================================================
Sleep 1s

# ============================================================
# 0:05-0:16  The four tiers
# "The server has four plans. Free, Solo at nineteen dollars a month, Team at
#  forty-nine, and Enterprise with custom pricing -- each raises your limits."
# ============================================================
Type "printf 'Free \\$0 | Solo \\$19/mo | Team \\$49/mo | Enterprise custom\\n'"
Enter
Sleep 3s

# ============================================================
# 0:16-0:27  What the limits cover
# "The limits cap three resources: how many workspaces you can create, how many
#  concurrent sessions, and how many panes -- so Free is one workspace, three
#  sessions, thirty panes; Team jumps to twenty, two hundred, two thousand."
# ============================================================
Type "printf 'Limits: workspaces / sessions / panes -- Free 1/3/30 ... Team 20/200/2000\\n'"
Enter
Sleep 3s

# ============================================================
# 0:27-0:38  Stripe integration
# "Payments run through Stripe. The billing page offers monthly or yearly with
#  Stripe Checkout, a Billing Portal for managing the subscription, and webhooks
#  that keep the server in sync."
# ============================================================
Type "echo 'Stripe: Checkout + Billing Portal + webhooks (monthly/yearly)'"
Enter
Sleep 3s

# ============================================================
# 0:38-0:50  Three layers of enforcement
# "And limits are enforced at three layers: workspaces server-side at creation,
#  sessions server-side at the WebSocket upgrade, and panes daemon-side in the
#  WorkspaceActor before a pane is spawned."
# ============================================================
Type "echo 'Enforced 3x: workspaces (create) | sessions (WS upgrade) | panes (daemon)'"
Enter
Sleep 4s
