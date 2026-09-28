# ROADMAP — todo-app

## Goal

Build a small, self-contained todo list manager that runs entirely in the
browser. A user opens a single HTML file from their filesystem and can
immediately add, complete, and manage a list of tasks, with the list
persisting across page reloads. No server, no install, no setup.

## Scope

- Add a new todo item.
- List all current todos.
- Mark a todo done / undone (toggle).
- Delete a single todo.
- Clear all completed todos in one action.
- Show a live count of remaining (not-done) todos.
- Persist the list across page reloads using `localStorage`.

## Non-goals

- No backend or server of any kind.
- No framework (React, Vue, etc.) and no bundler.
- No npm, no package manager, no external dependencies.
- No user accounts or multi-user support.
- No due dates, priorities, or tags.
- No drag-and-drop reordering.

## Deliverable

Three files under `todo-app/`:

- `todo-app/index.html`
- `todo-app/styles.css`
- `todo-app/app.js`

`index.html` must open directly from the filesystem (double-click, or
`file://` URL) and work with no server. This rules out ES modules
(`type="module"`) and `fetch()`, since both are blocked or unreliable under
`file://`. Use a plain `<script src="app.js"></script>` and vanilla DOM APIs.

## Acceptance

A person can verify all of the following by hand, in a browser, with no
dev tools required (though dev tools may help confirm persistence):

1. Open `todo-app/index.html` directly from the filesystem — the page loads
   with no console errors and no network requests.
2. Type a todo into the input and submit it (button and/or Enter key) — it
   appears in the list immediately.
3. Add several todos — each appears as its own list item, in a sensible order.
4. Click a todo (or its checkbox) — it visually marks as done (e.g.
   strikethrough) and the remaining count decreases by one.
5. Click it again — it toggles back to not-done and the count increases again.
6. Click a delete control on a single todo — that item is removed and no
   other items are affected.
7. Mark two or more todos done, then use "clear completed" — only the
   done items are removed; not-done items remain untouched.
8. The remaining count always matches the number of not-done items visible
   on screen.
9. Reload the page — all todos (with their done/not-done state) are still
   there, unchanged.
10. Submitting an empty todo (blank or whitespace-only) does not add a
    blank item to the list.
