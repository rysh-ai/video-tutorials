# Story 2: Installing Rysh (45s)
# Hook: "One command to install. One command to verify. Let's go."
#
# Prerequisites:
#   - rysh binary built and in PATH (for --version check)
#   - Terminal theme: Catppuccin Mocha or similar dark theme
#
# Run: vhs story-02-installing-rysh.tape

# --- Output Settings ---
Output story-02-installing-rysh.mp4
Output story-02-installing-rysh.gif

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
# "One command to install. One command to verify. Let's go."
# ============================================================
Sleep 2s

# ============================================================
# 0:02-0:10  macOS install with Homebrew
# "On macOS, use Homebrew. Tap the repo, then install."
# ============================================================
Type "echo '# macOS: brew tap rysh-works/rysh && brew install rysh'"
Enter
Sleep 3s

# ============================================================
# 0:10-0:16  Ubuntu install with apt
# "On Ubuntu or Debian, use apt."
# ============================================================
Type "echo '# Ubuntu: sudo apt install rysh'"
Enter
Sleep 3s

# ============================================================
# 0:16-0:22  Fedora install with dnf
# "On Fedora, use dnf."
# ============================================================
Type "echo '# Fedora: sudo dnf install rysh'"
Enter
Sleep 3s

# ============================================================
# 0:22-0:28  Windows install with winget
# "On Windows, use winget."
# ============================================================
Type "echo '# Windows: winget install RyshWorks.Rysh'"
Enter
Sleep 3s

# ============================================================
# 0:28-0:35  Verify installation
# "After installing, verify with --version."
# ============================================================
Type "rysh --version"
Enter
Sleep 4s

# ============================================================
# 0:35-0:42  Quick launch test
# "That's it. You're ready to launch rysh."
# ============================================================
Type "echo '# You are ready! Just type: rysh'"
Enter
Sleep 3s

# ============================================================
# 0:42-0:45  Hold final frame
# ============================================================
Sleep 3s
