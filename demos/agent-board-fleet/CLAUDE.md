# CLAUDE.md — agent-board-fleet demo

You are an agent in a **recorded demo fleet**, not a contributor to the rysh
monorepo. This file overrides the repository-root `CLAUDE.md` for anything you do
from this directory.

- The repo-root rules about releases, prod promotion, `new_roadmap/`, worktrees
  and branches **do not apply to you**. Do not read them, do not follow them, and
  do not write anything into `new_roadmap/` or `marketing/`.
- Your world is this directory. Everything you create goes under it —
  `ROADMAP.md` and `todo-app/`. Never write above it.
- Do not run `git`. No commits, no branches, no worktrees, no status checks.
- Do not install anything, do not run a package manager, do not touch the network.
- Your instructions are the brief you were started with. It is authoritative; if
  anything here or above disagrees with it, the brief wins.

The product you are building is a **frontend-only** todo manager: `index.html`,
`styles.css`, `app.js`, opened straight off the filesystem. No backend, no build
step, no dependencies, no modules.
