# CONTRACT — todo-app

This is the interface between `index.html`/`styles.css` (worker-1) and
`app.js` (worker-2). Both sides must match this exactly — neither side sees
the other's files while building.

## Ownership

- **worker-1** owns `index.html` and `styles.css` — all markup and visual
  styling. `index.html` must load `styles.css` via `<link>` and `app.js` via
  `<script src="app.js"></script>` (no `type="module"`), placed so the DOM
  exists before `app.js` runs (script tag at the end of `<body>`, or use
  `defer`).
- **worker-2** owns `app.js` — all behavior: adding, toggling, deleting,
  clearing completed, counting, and `localStorage` persistence. `app.js`
  creates all `<li>` list items dynamically; it does not expect any todos to
  be hardcoded in `index.html`.

## Static elements `index.html` must provide (exact ids)

| id                 | element                          | purpose                          |
|--------------------|-----------------------------------|-----------------------------------|
| `#new-todo`        | `<input type="text">`            | text entry for a new todo         |
| `#add-btn`         | `<button>`                       | submits the new todo              |
| `#todo-form`        | `<form>` wrapping input + button (optional but recommended so Enter submits) | enables Enter-to-submit |
| `#todo-list`        | `<ul>`                            | container `app.js` appends `<li>` items into |
| `#remaining-count`  | `<span>` (or similar inline el)  | `app.js` sets its text to the number of not-done todos |
| `#clear-done`       | `<button>`                       | clears all completed todos        |

`app.js` looks up every one of these ids with `document.getElementById(...)`
on load. If an id is missing or misspelled, that feature silently breaks.

## Markup `app.js` generates for one list item

For each todo, `app.js` appends this structure into `#todo-list`:

```html
<li class="todo-item" data-id="<todo-id>">
  <input type="checkbox" class="todo-toggle">
  <span class="todo-text">Buy milk</span>
  <button class="todo-delete">Delete</button>
</li>
```

- `data-id` carries the todo's unique id (string) — used to find/update/delete
  the right todo on click.
- `.todo-toggle` checkbox click toggles done/not-done for that id.
- `.todo-delete` button click removes that todo.
- Clicking the `<li>` itself (outside the button) is not required to toggle —
  the checkbox is the toggle control. `styles.css` may style the whole row as
  clickable-looking, but only `.todo-toggle` needs a click handler.

## Completed-item styling

When a todo is done, `app.js` adds the class **`completed`** to its `<li
class="todo-item">` (so the element's class becomes `"todo-item completed"`).
`styles.css` must define the visual treatment for `.todo-item.completed`
(e.g. strikethrough text, dimmed color). `app.js` removes the class when
toggled back to not-done.

## Behavioral notes worker-1 should design around

- Empty/whitespace-only submissions are rejected by `app.js` — no visual
  affordance needed for this beyond the input simply not clearing/adding.
- `#remaining-count` will be overwritten with a plain number (e.g. `"3"`) by
  `app.js` on every change — worker-1 can wrap it in surrounding text in
  `index.html` (e.g. `<span id="remaining-count">0</span> items left`) as
  long as the element with that id contains only the number.
