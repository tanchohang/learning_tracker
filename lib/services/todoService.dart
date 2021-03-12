import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:learning_tracker/models/todo_model.dart';

class TodoService {
  TodoService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User user = FirebaseAuth.instance.currentUser;

  Stream<List<TodoM>> getAll() {
    CollectionReference todos =
        _firestore.collection('users').doc(user.uid).collection('todos');
    return todos.snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => TodoM.fromJson(doc.data())).toList());
  }

  Future<void> add(TodoM todo) {
    CollectionReference todos =
        _firestore.collection('users').doc(user.uid).collection('todos');
    return todos
        .doc(todo.id)
        .set(todo.toMap())
        .then((value) => print("Todo added"))
        .catchError((err) => print("failed to add todo"));
  }

  Future<void> update(TodoM todo) {
    CollectionReference todos =
        _firestore.collection('users').doc(user.uid).collection('todos');
    return todos
        .doc(todo.id)
        .update(todo.toMap())
        .then((value) => print("Todo updated"))
        .catchError((err) => print("failed to update todo"));
  }

  Future<void> delete(TodoM todo) {
    CollectionReference todos =
        _firestore.collection('users').doc(user.uid).collection('todos');
    return todos.doc(todo.id).delete();
  }
}
