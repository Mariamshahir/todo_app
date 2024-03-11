import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo/models/myuser.dart';
import 'package:todo/models/todo_model.dart';

class ListProvider extends ChangeNotifier {
  List<Todo> todos = [];
  DateTime selectedDate = DateTime.now();

  onDateSelected(DateTime newDateTime) async {
    selectedDate = newDateTime;
    refreshTodo();
  }

  Future<void> refreshTodo() async {
    todos.clear();
    Myuser? currentUser = Myuser.currentUser;
    if (currentUser != null) {
      CollectionReference todoCollection = FirebaseFirestore.instance
          .collection(Myuser.collectionName)
          .doc(currentUser.id)
          .collection(Todo.collectionName);
      QuerySnapshot querySnapshot = await todoCollection.orderBy("date").get();
      todos = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        Timestamp dateAsTime = data["date"];
        return Todo(
          id: data["id"],
          task: data["title"],
          description: data["description"],
          dateTime: dateAsTime.toDate(),
          isDone: data["isDone"],
        );
      }).toList();
    }
    notifyListeners();
  }

  void clearData() {
    todos = [];
    selectedDate = DateTime.now();
    Myuser.currentUser = null;
  }

  void removeTodoItem(Todo todo) async {
    todos.remove(todo);
    Myuser? currentUser = Myuser.currentUser;
    if (currentUser != null) {
      CollectionReference todoCollection = FirebaseFirestore.instance
          .collection(Myuser.collectionName)
          .doc(currentUser.id)
          .collection(Todo.collectionName);
      await todoCollection.doc(todo.id).delete();
    }
    notifyListeners();
  }
}
