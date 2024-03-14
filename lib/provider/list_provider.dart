import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo/models/myuser.dart';
import 'package:todo/models/todo_model.dart';

class ListProvider extends ChangeNotifier {
  List<Todo> todos = [];
  DateTime selectedDate = DateTime.now();

  onDateSelected(DateTime newDateTime) async {
    selectedDate = newDateTime;
    await refreshTodo();
    notifyListeners();
  }

  Future<void> refreshTodo() async {
    var datetimefelter=selectedDate.copyWith(hour: 0,microsecond: 0,millisecond: 0,minute: 0,second: 0);
    todos.clear();
    Myuser? currentUser = Myuser.currentUser;
    if (currentUser != null) {
      CollectionReference todoCollection = FirebaseFirestore.instance
          .collection(Myuser.collectionName)
          .doc(currentUser.id)
          .collection(Todo.collectionName);
      QuerySnapshot querySnapshot = await todoCollection.orderBy("date").where("date",isEqualTo: Timestamp.fromDate(datetimefelter)).get();
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

  void removeTodo(Todo todo) async {
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

  void updateIsDone(Todo todo, bool isDone) async {
    Myuser? currentUser = Myuser.currentUser;
    if (currentUser != null) {
      CollectionReference todoCollection = FirebaseFirestore.instance
          .collection(Myuser.collectionName)
          .doc(currentUser.id)
          .collection(Todo.collectionName);
      await todoCollection.doc(todo.id).update({"isDone": isDone});
      todo.isDone = isDone;
    }
    notifyListeners();
  }

  Future<void> editTodo(Todo todo) async {
    Myuser? currentUser = Myuser.currentUser;
    if (currentUser != null) {
      CollectionReference todoCollection = FirebaseFirestore.instance
          .collection(Myuser.collectionName)
          .doc(currentUser.id)
          .collection(Todo.collectionName);
      await todoCollection.doc(todo.id).update({
        'title': todo.task,
        'description': todo.description,
        'date': Timestamp.fromDate(todo.dateTime!),
      });
     return await refreshTodo();
    }
  }
}
