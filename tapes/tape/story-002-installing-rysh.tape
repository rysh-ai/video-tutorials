# Story 2: Installing Rysh (45s)
# Hook: "One command to install. macOS, Linux, Windows, or straight from source."
#
# Run: vhs story-002-installing-rysh.tape

# --- Output Settings ---
Output story-002-installing-rysh.mp4
Output story-002-installing-rysh.gif

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
# 0:00-0:04  Title / Hook
# "One command to install -- on every platform Rysh supports."
# ============================================================
Sleep 4s

# ============================================================
# 0:04-0:12  macOS via Homebrew
# "On macOS, tap the repo and brew install rysh.
#  Two commands and you're done."
# ============================================================
Type "# brew tap rysh-works/rysh && brew install rysh"
Sleep 2.64s
Enter
Sleep 1.76s

# ============================================================
# 0:12-0:20  Linux package managers
# "On Debian or Ubuntu, apt install rysh.
#  On Fedora or RHEL, dnf install rysh."
# ============================================================
Type "# sudo apt install rysh     (Debian / Ubuntu)"
Sleep 0.5s
Enter
Type "# sudo dnf install rysh     (Fedora / RHEL)"
Sleep 0.5s
Enter
Sleep 0.25s

# ============================================================
# 0:20-0:27  Windows
# "On Windows, install with WinGet."
# ============================================================
Type "# winget install RyshWorks.Rysh     (Windows)"
Sleep 2.37s
Enter
Sleep 1.18s

# ============================================================
# 0:27-0:36  From source
# "Or build from source -- it's just Go.
#  make build, then make install."
# ============================================================
Type "# git clone https://github.com/rysh-works/rysh && cd rysh"
Sleep 0.99s
Enter
Type "# make build && make install"
Sleep 0.99s
Enter
Sleep 0.5s

# ============================================================
# 0:36-0:45  Verify the install
# "Verify it with rysh --version. You're ready to go."
# ============================================================
Type "rysh --version"
Enter
Sleep 7.88s
