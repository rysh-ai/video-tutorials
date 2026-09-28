# YouTube copy — agent-board-fleet-codex.vover.mp4

**File:** `out/agent-board-fleet-codex.vover.mp4` · 1920x1080 · 6:14 · narration + subtitle track
(a burned-in-subtitle cut is `out/agent-board-fleet-codex.vover.subs.mp4`)

**Claim-table check:** every claim below maps to a row in
`new_roadmap/designs/024-investor-claims.md` — 281 (`CLAIM`, the shared threaded
board), 282 (`NARROW`, quoted verbatim), 284 (`NARROW`, the org chart is named as
an in-house script). Row 283 (*"fully autonomous multi-agent delivery — hand it a
goal and walk away"*) is `DO-NOT-CLAIM` and is deliberately absent; so is any
sandboxing claim (row 279), since this run was filmed with the sandbox switched
off. Open source is not mentioned at all — row 311 is `NARROW` with three guards
and needs re-verification before any asset cites it.

---

## Title (79 chars)

Four Codex agents build a web app in one terminal — and report to a shared board

### Alternates

- One terminal, four Codex agents, one shared board — a web app built live (6 min)
- Watching four Codex agents build a todo app on a shared agents board

---

## Description

Four Codex agents work in a single terminal session and build a browser-only todo
manager between them. Nothing is sped up and nothing is staged — this is one
unbroken take, and the interesting part is not the app.

You are looking at one rysh session with three lanes. On the left, planning: a
roadmap agent and a fleet manager. In the middle, two workers building in
parallel. On the right, the agents board — a shared, threaded feed every agent
posts to, before and after each step. That right-hand column is the whole project
happening in one place.

The run:

The roadmap agent opens the board, writes down the goal — HTML, CSS and
JavaScript, no backend, no build step, no dependencies — waits until the other
three have checked in, and hands off. The fleet manager splits the work by layer
and, before either worker starts, writes a contract: the shared element ids, the
markup of one todo item, and which file belongs to whom. Two agents are about to
edit one page without ever reading each other's files, and that contract is the
only thing holding them together.

Then verification finds a real bug. Checking the finished app, the manager spots
that the script writes a whole phrase into the remaining-count element while the
page already supplies the words around it — duplicated text on screen. It does
not fix it. It names the mismatch, sends the file back to the worker who owns it,
posts that it is blocked, and re-checks after the correction. That exchange is on
camera at 4:33, and it is the best thing in the video.

Timings on screen are real: work orders out at 2:38, both workers signed off at
4:03, the defect caught and fixed, done at 6:03.

⏱ CHAPTERS

0:00  One session, three lanes
0:34  The roadmap agent opens the board
0:45  The fleet checks in
1:04  The goal, written down
1:36  Handed to the fleet manager
2:20  A contract, so two agents can edit one page
2:38  Work orders out — the parallel build
3:50  Both workers sign off on the board
4:33  The manager finds a real defect
5:00  Reworked, re-verified
5:36  Checked against the acceptance list
6:03  Done

🔌 HOW THE AGENTS COORDINATE

Down the chain is a message; up the chain is the board. The roadmap agent messages
the manager and the manager messages each worker, but nobody reports back by
message. Workers post that they are finished and the manager watches the board for
it, because a push interrupts an agent mid-task and can be missed — a post cannot.
Every agent in a session reports to one shared board on your machine. It is a
monitoring view, not an audit log, and it does not cross machines.

🧩 WHAT IS THE PRODUCT AND WHAT IS THE SCRIPT

Worth being exact about, because demos blur this. The panes and lanes, the
given-names agents address each other by, the per-pane metadata, the message
routing and the agents board itself all ship in the rysh binary. The roadmap →
manager → worker hierarchy on top of them does not: that is an in-house script
written for this demo, along with the four briefs the agents are started with.
There is no shipped orchestrator and no org-chart data model underneath — the
registry knows a fleet's members, not that one of them manages another.

This is a scripted demo, not a system you hand a goal and walk away from.

✅ CHECKED AFTER THE RUN, NOT JUST CLAIMED ON SCREEN

- `node --check` clean on the generated JavaScript
- every element id the script looks up exists in the markup
- no `import`, `export`, `require` or `fetch` anywhere — it opens straight off disk
- plain `<link>` and `<script src>` tags, no modules, no bundler

🛠 SETUP

rysh (an agentic terminal multiplexer), one session, one tab, three lanes, five
panes. Agents are Codex CLI 0.147.0 on gpt-5.6-sol at high reasoning effort.
Recorded with VHS at 1920x1080. The same scenario run by Claude agents finishes in
3:29 — about 1.7x faster, and it never tripped the verification path you see here.

🔗 LINKS

rysh — https://rysh.ai
Design partner programme — https://rysh.ai/design-partner

#AI #AIagents #terminal #developertools #codex #multiagent #softwareengineering

---

## Notes for whoever publishes this

- **Do not add "autonomous" to the title or the first line.** Row 283 is
  `DO-NOT-CLAIM`. The "scripted demo" sentence in the body is what keeps the rest
  of the description inside the table; do not cut it for length.
- **Do not add a sandboxing or isolation claim.** Row 279 is `DO-NOT-CLAIM`, and
  this run was filmed with `--dangerously-bypass-approvals-and-sandbox`.
- **Do not link the GitHub Releases page** if links are ever expanded — it is
  frozen three releases back (row 311, guard 1).
- Both links returned 200 on 2026-08-18. Re-check before publishing.
- Timestamps are pinned to THIS take. If the video is re-recorded they are wrong
  until re-derived from the frames — see `voiceover/agent-board-fleet-codex.say`.
