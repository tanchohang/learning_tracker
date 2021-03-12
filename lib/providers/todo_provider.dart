import 'package:learning_tracker/models/todo_model.dart';
import 'package:learning_tracker/services/todoService.dart';
import 'package:uuid/uuid.dart';

class TodoStateModel {
  final TodoService _todoService = TodoService();
  var uuid = Uuid();

  Stream<List<TodoM>> get todos => _todoService.getAll();

  void add(TodoM todo) {
    todo.id = uuid.v1();
    _todoService.add(todo);
  }

  void update(TodoM todo) {
    _todoService.update(todo);
  }

  void remove(TodoM todo) {
    _todoService.delete(todo);
  }

  void archive() {
    //   _list.clear();create
    //   notifyListeners();
  }

  void completed() {}
}
