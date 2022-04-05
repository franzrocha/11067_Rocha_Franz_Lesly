import 'package:flutter/material.dart';
import 'package:todo_app/src/classes/todo_model.dart';



class TodoController with ChangeNotifier {
  List<Todo> todos = [];

  toggleDone(Todo todo) {
    todo.toggleDone();
    notifyListeners();
  }

  addTodo(Todo todo) {
    todos.add(todo);
    notifyListeners();
  }

  removeTodo(Todo toBeDeleted) {
    todos.remove(toBeDeleted);
    notifyListeners();
  }

  updateTodo(Todo todo, String newDetails) {
    todo.updateDetails(newDetails);
    notifyListeners();
  }
 }