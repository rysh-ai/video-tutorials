# Story 4: Configuring Rysh (45s)
# Hook: "One config file. Environment overrides. Full control."
#
# Prerequisites:
#   - rysh binary built and in PATH
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-04-configuring-rysh.tape

# --- Output Settings ---
Output story-04-configuring-rysh.mp4
Output story-04-configuring-rysh.gif

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
# 0:00-0:02  Title / Hook
# "One config file. Environment overrides. Full control."
# ============================================================
Sleep 2s

# ============================================================
# 0:02-0:08  Show the config file location
# "Rysh looks for its config at ~/.config/rysh/rysh.config.
#  It uses TOML format -- clean and readable."
# ============================================================
Type "cat ~/.config/rysh/rysh.config"
Enter
Sleep 4s

# ============================================================
# 0:08-0:15  Show the provider section
# "The provider section sets your AI backend and API key."
# ============================================================
Type "echo '[provider]'"
Enter
Sleep 1s
Type "echo 'api_key = 'sk-ant-...''"
Enter
Sleep 2s

# ============================================================
# 0:15-0:22  Show the UI section
# "The ui section controls how rysh looks and behaves on launch."
# ============================================================
Type "echo '[ui]'"
Enter
Sleep 1s
Type "echo 'initial_tabs = 2'"
Enter
Sleep 2s

# ============================================================
# 0:22-0:29  Show the upstream section
# "The upstream section enables remote features and collaboration."
# ============================================================
Type "echo '[upstream]'"
Enter
Sleep 1s
Type "echo 'enabled = true'"
Enter
Sleep 2s

# ============================================================
# 0:29-0:37  Show environment variable overrides
# "Every config option can be overridden with an environment variable.
#  Prefix with RYSH_ and you're set."
# ============================================================
Type "echo 'RYSH_API_KEY=sk-ant-... rysh'"
Enter
Sleep 3s

Type "echo '# Environment variables always take priority over the config file.'"
Enter
Sleep 2s

# ============================================================
# 0:37-0:42  Summary
# "That's all you need. Config file for defaults,
#  env vars for overrides."
# ============================================================
Type "echo '# Config: ~/.config/rysh/rysh.config'"
Enter
Sleep 1.5s
Type "echo '# Override: RYSH_<KEY>=<value> rysh'"
Enter
Sleep 1.5s

# ============================================================
# 0:42-0:45  Hold final frame
# ============================================================
Sleep 3s
