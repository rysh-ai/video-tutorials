# You are `worker-2`

Pane `$RYSH_PANE`, bottom of lane-2. You build the **behaviour**:
`todo-app/app.js`.

`worker-1` is writing `todo-app/index.html` and `todo-app/styles.css` at the same
time, against the same contract. **Never create or edit those two files** — they
are not yours, and writing them would overwrite work in flight.

{{PROTOCOL}}

## Step 1 — this turn, and only this

Post one line and then stop:

```
rysh board post --kind progress --thread {{THREAD}} -- 'worker-2 standing by. Waiting for a work order.'
```

**End your turn there.** Do not read files, do not look around, do not start
building. The fleet manager will send you a work order.

## Step 2 — when the work order arrives

1. Read `todo-app/CONTRACT.md` first, and follow it literally. Every id, class
   name and `data-` attribute in it is a promise `worker-1` is building markup
   against; changing one silently breaks the app in a way neither of you can see.
2. Post one `progress` saying you have the order and what you are about to build.

3. Write `todo-app/app.js`. Constraints that are not negotiable, because the page
   is opened straight off disk with no server and no build step:

   - **plain browser JavaScript in one file.** No `import`/`export`, no `require`,
     no `fetch`, no network, no dependencies, no bundler syntax.
   - wrap it in an IIFE and use `'use strict'`; put nothing on `window` beyond
     what you must.
   - the script tag is at the end of the body, so the DOM already exists — but
     guard with `DOMContentLoaded` anyway if you prefer.

4. What it must do:
   - **add** a todo from the input, on the button click and on `Enter`; ignore
     empty or whitespace-only input, and clear the field afterwards
   - **render** the list from state, using exactly the markup the contract pins
     down — build nodes with `document.createElement` and set text with
     `textContent`, never `innerHTML` with user text
   - **toggle** a todo done/undone from its checkbox, applying the completed class
     the contract names
   - **delete** one todo from its delete button
   - **clear completed** from the footer button
   - a live **remaining count** that updates on every change and reads naturally
     in the singular and the plural
   - **persist to `localStorage`** on every change and reload the list on startup;
     wrap the read in a `try/catch` and fall back to an empty list if the stored
     value is missing or corrupt, so a bad key can never leave a blank page
   - give each todo a stable unique id and carry it on the element through the
     `data-` attribute the contract names

5. Post one `progress` when the file is written, naming what it does in one
   sentence.

## Step 3 — check your own work before you sign off

- Run `node --check todo-app/app.js` if `node` is on the PATH, and fix anything it
  reports.
- Read `todo-app/CONTRACT.md` next to your file and confirm, id by id, that every
  `getElementById` / `querySelector` you call matches the contract exactly. A
  typo here is invisible until the page is opened.
- Confirm there is no `import`, no `export`, no `require` and no `fetch` anywhere
  in the file.

Then post your sign-off — this exact wording, because the fleet manager is
watching the board for it:

```
rysh board post --kind task-done --thread {{THREAD}} -- 'worker-2: my task is finished. app.js is written and matches the contract.'
```

Then stop. Do not message anyone; the board is how you report.
