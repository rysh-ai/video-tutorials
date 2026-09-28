# Todo Manager Roadmap

## Goal

Build a small, dependable todo manager that anyone can open directly in a browser and use immediately. It should cover the everyday flow of capturing work, tracking what remains, completing or removing items, and retaining the list across page reloads while staying simple enough to understand at a glance.

## Scope

- Add a todo.
- List all todos.
- Mark a todo done or undone.
- Delete one todo.
- Clear all completed todos.
- Show a live count of todos left to do.
- Persist the list across page reloads with `localStorage`.

## Non-goals

No backend, server, framework, bundler, npm, accounts, due dates, or drag-and-drop.

## Deliverable

The complete app consists of `todo-app/index.html`, `todo-app/styles.css`, and `todo-app/app.js`. Opening `index.html` directly from the filesystem must work without hitting `file://` restrictions, so the app must not use ES modules or `fetch`.

## Acceptance

1. Open `todo-app/index.html` directly from the filesystem and confirm the app loads without a server or console errors.
2. Enter a non-empty todo, submit it, and confirm it appears in the list and the input clears.
3. Add more todos and confirm every item appears and the remaining count updates immediately.
4. Mark an active todo done, confirm its completed state is visible, and confirm the remaining count decreases.
5. Mark that todo undone and confirm its active appearance and the remaining count are restored.
6. Delete one todo and confirm only that item disappears and the remaining count stays accurate.
7. Complete multiple todos, choose clear completed, and confirm every completed item is removed while active items remain.
8. Reload the page after adding, completing, and deleting items; confirm the current list and completion states survive the reload.
9. Confirm empty or whitespace-only input does not create a todo.
