# Todo App Worker Contract

Both workers must follow this interface exactly. The app is plain HTML, CSS,
and browser JavaScript opened directly from `index.html`.

## Static elements

`index.html` must provide every element below, and `app.js` may look them up by
these exact IDs:

- `#todo-form` — the form used to add a todo
- `#new-todo` — the text input
- `#add-btn` — the form's submit button
- `#todo-list` — the list that receives generated todo items
- `#remaining-count` — the element containing the numeric active-todo count
- `#clear-done` — the button that removes all completed todos

## Generated todo item

For each todo, `app.js` must generate this exact structure. The bracketed
`completed` class and `checked` attribute are present only when the todo is done.
The todo text must be assigned with `textContent`, not inserted as HTML.

```html
<li class="todo-item[ completed]" data-id="<todo id>">
  <input class="todo-toggle" type="checkbox" data-action="toggle"[ checked]>
  <span class="todo-text"><todo text></span>
  <button class="delete-btn" type="button" data-action="delete" aria-label="Delete todo">Delete</button>
</li>
```

The class `completed` on `.todo-item` is the sole completion-state hook CSS
must style. The `data-id` attribute on `.todo-item` carries the todo's unique ID.

## Ownership

- `index.html` and `styles.css` own all static markup, accessible presentation,
  responsive layout, and styles for every class named above.
- `app.js` owns all behavior: loading and saving todos with `localStorage`,
  adding, rendering, toggling, deleting, clearing completed items, and updating
  the remaining count.
- `index.html` must load `styles.css` and `app.js` with ordinary relative
  `<link>` and `<script src>` tags. Do not use modules.

Use the localStorage key `todo-manager.todos`. Store an array of objects shaped
as `{ id, text, completed }`.
