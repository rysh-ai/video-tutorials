# Group 14: Tools — Git, Build & Test (Stories 53-56)

Narration scripts for the development-workflow tools. These show prompt mode (`<`) driving git, build, test, and lint. The reading and running tools are free; only `git_commit` and the file edits that fix problems are approval-gated.

**Total duration:** ~2 min 45s

---

## Story 53: Git Tools (45s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Git Tools" | "Summarize your changes and commit -- the agent reads git for free, but the commit waits for you." |
| 0:03 | Type `rysh` in a repo with changes | "Start rysh inside a git repository with a few uncommitted changes." |
| 0:08 | Double-press Escape to prompt mode | "Double-press Escape to reach prompt mode." |
| 0:13 | Type "summarize my changes and commit them" | "Ask it to summarize your work and commit. The agent calls git_status, git_diff, and git_log -- all read-only -- to understand what changed." |
| 0:24 | AI drafts a commit message | "Then it drafts a commit message for you." |
| 0:30 | Approval footer for git_commit | "The git_commit tool is the one that needs approval. The footer shows the proposed message; press y to approve." |
| 0:36 | Press `y`, commit lands | "Capital N lets you reject with a reason if you want a different message." |
| 0:40 | End card | "Reads are instant, writes are gated -- git, the safe way." |

### Key Moments to Annotate
- [0:13] Highlight `git_status`, `git_diff`, `git_log` (no approval)
- [0:30] Highlight `git_commit` (approval) with message preview

---

## Story 54: Building Your Project (40s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Building Your Project" | "Ask the agent to build -- it compiles, parses the errors, and fixes them." |
| 0:03 | Type `rysh` in a buildable project | "Launch rysh inside a project you can compile." |
| 0:08 | Double-press Escape to prompt mode | "Double-press Escape for prompt mode." |
| 0:13 | Type "build the project and fix any compile errors" | "Ask it to build and fix errors. The build tool compiles and returns structured, parsed errors -- file, line, and message." |
| 0:24 | AI reads errors | "So the agent knows exactly what broke. The build tool itself needs no approval." |
| 0:30 | Proposed fix with diff | "If it proposes a code change, that file edit is the part that asks for approval -- you review the diff, approve, and it builds again." |
| 0:37 | End card | "Build, read the errors, fix, repeat -- hands on the wheel." |

### Key Moments to Annotate
- [0:13] Highlight the `build` tool (no approval)
- [0:30] Callout: the fix (file_edit) is approval-gated

---

## Story 55: Running Tests (45s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Running Tests" | "Run the tests and fix the failures -- test_run gives structured pass/fail." |
| 0:03 | Type `rysh` in a project with tests | "Start rysh inside a project that has a test suite." |
| 0:08 | Double-press Escape to prompt mode | "Double-press Escape to enter prompt mode." |
| 0:13 | Type "run the tests and fix any failures" | "Ask it to run the tests and fix what fails. The test_run tool executes your suite and returns structured results -- which passed, which failed, and why." |
| 0:26 | AI reads failures | "No approval needed to run them; the agent reads the failures directly." |
| 0:32 | Proposed fix with diff | "When the agent proposes a fix, the file edit is approval-gated -- you see the diff, approve, and it reruns the suite to confirm green." |
| 0:42 | End card | "Structured test results in, fixes out -- one prompt at a time." |

### Key Moments to Annotate
- [0:13] Highlight the `test_run` tool (no approval)
- [0:32] Callout: fix is approval-gated, then re-run

---

## Story 56: Linting (40s)

### Scene Breakdown

| Time | Visual | Narration |
|------|--------|-----------|
| 0:00 | Title card: "Linting" | "Lint and fix -- the agent runs go vet, staticcheck, and golangci-lint, then cleans up." |
| 0:03 | Type `rysh` in a Go project | "Launch rysh inside your project." |
| 0:08 | Double-press Escape to prompt mode | "Double-press Escape for prompt mode." |
| 0:13 | Type "lint this project and fix the warnings" | "Ask it to lint and fix. The lint tool runs the standard Go linters -- go vet, staticcheck, and golangci-lint -- and returns each finding." |
| 0:24 | AI reads warnings | "Running the linters needs no approval; the agent reads the warnings straight back." |
| 0:30 | Proposed fix with diff | "As with build and test, the actual code fixes are approval-gated -- you review the diff before any change, then it re-lints to verify." |
| 0:37 | End card | "Clean code, on request -- linters run, fixes reviewed." |

### Key Moments to Annotate
- [0:13] Highlight the `lint` tool: go vet, staticcheck, golangci-lint (no approval)
- [0:30] Callout: fix is approval-gated, then re-lint
