(function () {
  'use strict';

  var STORAGE_KEY = 'todo-manager.todos';

  function initialise() {
    var form = document.getElementById('todo-form');
    var input = document.getElementById('new-todo');
    var list = document.getElementById('todo-list');
    var remainingCount = document.getElementById('remaining-count');
    var clearDoneButton = document.getElementById('clear-done');
    var todos = loadTodos();

    function loadTodos() {
      try {
        var stored = localStorage.getItem(STORAGE_KEY);

        if (stored === null) {
          return [];
        }

        var parsed = JSON.parse(stored);
        var seenIds = Object.create(null);
        var isValid = Array.isArray(parsed) && parsed.every(function (todo) {
          if (
            !todo ||
            typeof todo.id !== 'string' ||
            typeof todo.text !== 'string' ||
            typeof todo.completed !== 'boolean' ||
            seenIds[todo.id]
          ) {
            return false;
          }

          seenIds[todo.id] = true;
          return true;
        });

        return isValid ? parsed : [];
      } catch (error) {
        return [];
      }
    }

    function saveTodos() {
      try {
        localStorage.setItem(STORAGE_KEY, JSON.stringify(todos));
      } catch (error) {
        // The app remains usable when storage is unavailable.
      }
    }

    function createId() {
      if (typeof crypto !== 'undefined' && typeof crypto.randomUUID === 'function') {
        return crypto.randomUUID();
      }

      return Date.now().toString(36) + '-' + Math.random().toString(36).slice(2);
    }

    function updateRemainingCount() {
      var remaining = todos.filter(function (todo) {
        return !todo.completed;
      }).length;

      remainingCount.textContent = String(remaining);
    }

    function createTodoItem(todo) {
      var item = document.createElement('li');
      item.className = 'todo-item';
      item.dataset.id = todo.id;

      if (todo.completed) {
        item.classList.add('completed');
      }

      var toggle = document.createElement('input');
      toggle.className = 'todo-toggle';
      toggle.type = 'checkbox';
      toggle.dataset.action = 'toggle';
      toggle.checked = todo.completed;

      var text = document.createElement('span');
      text.className = 'todo-text';
      text.textContent = todo.text;

      var deleteButton = document.createElement('button');
      deleteButton.className = 'delete-btn';
      deleteButton.type = 'button';
      deleteButton.dataset.action = 'delete';
      deleteButton.setAttribute('aria-label', 'Delete todo');
      deleteButton.textContent = 'Delete';

      item.append(toggle, text, deleteButton);
      return item;
    }

    function render() {
      var fragment = document.createDocumentFragment();

      todos.forEach(function (todo) {
        fragment.appendChild(createTodoItem(todo));
      });

      list.replaceChildren(fragment);
      updateRemainingCount();
    }

    function commit() {
      saveTodos();
      render();
    }

    form.addEventListener('submit', function (event) {
      event.preventDefault();

      var todoText = input.value.trim();
      if (!todoText) {
        return;
      }

      todos.push({
        id: createId(),
        text: todoText,
        completed: false
      });

      input.value = '';
      commit();
    });

    list.addEventListener('change', function (event) {
      var toggle = event.target.closest('[data-action="toggle"]');
      if (!toggle || !list.contains(toggle)) {
        return;
      }

      var item = toggle.closest('.todo-item');
      var todo = todos.find(function (candidate) {
        return candidate.id === item.dataset.id;
      });

      if (todo) {
        todo.completed = toggle.checked;
        commit();
      }
    });

    list.addEventListener('click', function (event) {
      var deleteButton = event.target.closest('[data-action="delete"]');
      if (!deleteButton || !list.contains(deleteButton)) {
        return;
      }

      var item = deleteButton.closest('.todo-item');
      todos = todos.filter(function (todo) {
        return todo.id !== item.dataset.id;
      });
      commit();
    });

    clearDoneButton.addEventListener('click', function () {
      todos = todos.filter(function (todo) {
        return !todo.completed;
      });
      commit();
    });

    render();
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initialise);
  } else {
    initialise();
  }
}());
