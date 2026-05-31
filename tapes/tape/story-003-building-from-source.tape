# Story 3: Building From Source (40s)
# Hook: "Rysh is just Go. Clone it, make build, and run your own binary."
#
# Run: vhs story-003-building-from-source.tape

# --- Output Settings ---
Output story-003-building-from-source.mp4
Output story-003-building-from-source.gif

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
# "Rysh is written in Go, so building from source
#  takes just a few commands."
# ============================================================
Sleep 2s

# ============================================================
# 0:04-0:12  Clone the repo
# "Start by cloning the repository and stepping in."
# ============================================================
Type "# git clone https://github.com/rysh-works/rysh && cd rysh"
Sleep 2s
Enter
Sleep 2s

# ============================================================
# 0:12-0:20  Build the binary
# "Run make build. The Go toolchain compiles
#  a local rysh binary right here."
# ============================================================
Type "# make build"
Sleep 2s
Enter
Sleep 2s
Type "# ./rysh --version"
Enter
Sleep 2s

# ============================================================
# 0:20-0:28  Install it
# "make install copies it into ~/.local/bin
#  so you can run rysh from anywhere."
# ============================================================
Type "# make install"
Sleep 2s
Enter
Sleep 2s

# ============================================================
# 0:28-0:36  Add to PATH
# "If needed, add ~/.local/bin to your PATH."
# ============================================================
Type "# export PATH=$HOME/.local/bin:$PATH"
Sleep 2s
Enter
Sleep 1s

# ============================================================
# 0:36-0:40  Confirm
# "Confirm with rysh --version and you're building
#  from your own source."
# ============================================================
Type "rysh --version"
Enter
Sleep 4s
