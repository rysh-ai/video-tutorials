# Story 4: Configuring Rysh (50s)
# Hook: "One TOML file controls everything -- and every setting has an env-var override."
#
# Run: vhs story-004-configuring-rysh.tape

# --- Output Settings ---
Output story-004-configuring-rysh.mp4
Output story-004-configuring-rysh.gif

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
# 0:00-0:05  Title / Hook
# "Rysh reads one TOML config file --
#  and every setting also has an environment-variable override."
# ============================================================
Sleep 5.04s

# ============================================================
# 0:05-0:13  Where the config lives
# "The config lives at ~/.config/rysh/rysh.config,
#  or rysh.config in your current directory."
# ============================================================
Type "cat ~/.config/rysh/rysh.config"
Sleep 2.3s
Enter
Sleep 3.44s

# ============================================================
# 0:13-0:24  The [provider] section
# "The provider section sets your model and API key.
#  Set api_key to call the Anthropic API directly --
#  otherwise Rysh falls back to the claude CLI."
# ============================================================
Type "echo '[provider]'"
Enter
Type "echo 'model = claude-sonnet-4-20250514'"
Enter
Type "echo 'api_key = sk-ant-...'"
Sleep 1.86s
Enter
Sleep 2.78s

# ============================================================
# 0:24-0:34  The [ui] section
# "The ui section controls your shell and how many
#  tabs and panes open on a fresh start."
# ============================================================
Type "echo '[ui]'"
Enter
Type "echo 'shell = /bin/bash'"
Enter
Type "echo 'initial_tabs = 2'"
Enter
Type "echo 'initial_panes = 1'"
Sleep 1.46s
Enter
Sleep 2.18s

# ============================================================
# 0:34-0:42  The [upstream] section
# "The upstream section enables remote sharing --
#  point it at a rysh-server and drop in an API key."
# ============================================================
Type "echo '[upstream]'"
Enter
Type "echo 'enabled = true'"
Enter
Type "echo 'url = https://rysh.works/workspaces/team'"
Enter
Type "echo 'api_key = ...'"
Sleep 0.1s
Enter
Sleep 0.1s

# ============================================================
# 0:42-0:50  Environment override
# "Every value has an env override. Just prefix your
#  launch -- here, RYSH_API_KEY -- and rysh picks it up."
# ============================================================
Type "RYSH_API_KEY=sk-ant-xxxx rysh"
Sleep 2.49s
Enter
Sleep 3.33s
