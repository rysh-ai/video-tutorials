(function () {
  'use strict';

  var STORAGE_KEY = 'todo-app-todos';

  var todoList = document.getElementById('todo-list');
  var newTodoInput = document.getElementById('new-todo');
  var addBtn = document.getElementById('add-btn');
  var todoForm = document.getElementById('todo-form');
  var remainingCount = document.getElementById('remaining-count');
  var clearDoneBtn = document.getElementById('clear-done');

  var todos = loadTodos();

  function loadTodos() {
    try {
      var raw = localStorage.getItem(STORAGE_KEY);
      if (!raw) return [];
      var parsed = JSON.parse(raw);
      if (!Array.isArray(parsed)) return [];
      return parsed;
    } catch (e) {
      return [];
    }
  }

  function saveTodos() {
    try {
      localStorage.setItem(STORAGE_KEY, JSON.stringify(todos));
    } catch (e) {
      // ignore storage failures (e.g. quota exceeded, disabled storage)
    }
  }

  function makeId() {
    return 'id-' + Date.now().toString(36) + '-' + Math.random().toString(36).slice(2, 8);
  }

  function render() {
    todoList.textContent = '';

    for (var i = 0; i < todos.length; i++) {
      var todo = todos[i];

      var li = document.createElement('li');
      li.className = 'todo-item' + (todo.done ? ' completed' : '');
      li.setAttribute('data-id', todo.id);

      var toggle = document.createElement('input');
      toggle.type = 'checkbox';
      toggle.className = 'todo-toggle';
      toggle.checked = !!todo.done;

      var text = document.createElement('span');
      text.className = 'todo-text';
      text.textContent = todo.text;

      var del = document.createElement('button');
      del.className = 'todo-delete';
      del.textContent = 'Delete';

      li.appendChild(toggle);
      li.appendChild(text);
      li.appendChild(del);
      todoList.appendChild(li);
    }

    var remaining = 0;
    for (var j = 0; j < todos.length; j++) {
      if (!todos[j].done) remaining++;
    }
    remainingCount.textContent = String(remaining);
  }

  function addTodo() {
    var value = newTodoInput.value.trim();
    if (!value) return;

    todos.push({ id: makeId(), text: value, done: false });
    newTodoInput.value = '';
    saveTodos();
    render();
  }

  function toggleTodo(id) {
    for (var i = 0; i < todos.length; i++) {
      if (todos[i].id === id) {
        todos[i].done = !todos[i].done;
        break;
      }
    }
    saveTodos();
    render();
  }

  function deleteTodo(id) {
    todos = todos.filter(function (t) {
      return t.id !== id;
    });
    saveTodos();
    render();
  }

  function clearCompleted() {
    todos = todos.filter(function (t) {
      return !t.done;
    });
    saveTodos();
    render();
  }

  if (todoForm) {
    todoForm.addEventListener('submit', function (e) {
      e.preventDefault();
    });
  }

  addBtn.addEventListener('click', function (e) {
    e.preventDefault();
    addTodo();
  });

  newTodoInput.addEventListener('keydown', function (e) {
    if (e.key === 'Enter') {
      e.preventDefault();
      addTodo();
    }
  });

  todoList.addEventListener('change', function (e) {
    if (e.target.classList.contains('todo-toggle')) {
      var li = e.target.closest('.todo-item');
      if (li) toggleTodo(li.getAttribute('data-id'));
    }
  });

  todoList.addEventListener('click', function (e) {
    if (e.target.classList.contains('todo-delete')) {
      var li = e.target.closest('.todo-item');
      if (li) deleteTodo(li.getAttribute('data-id'));
    }
  });

  clearDoneBtn.addEventListener('click', function (e) {
    e.preventDefault();
    clearCompleted();
  });

  render();
})();
