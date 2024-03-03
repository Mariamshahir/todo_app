import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo/models/todo_model.dart';

class ListProvider extends ChangeNotifier {
  List<Todo> todos = [];
  DateTime selectedDate = DateTime.now();

  onDateSelected(DateTime newDateTime) async {
    selectedDate = newDateTime;
    refreshTodo();
  }

  void refreshTodo() async {
    todos.clear();
    CollectionReference todoCollection =
    FirebaseFirestore.instance.collection(Todo.collectionName);
    QuerySnapshot querySnapshot =
    await todoCollection.get();
    todos = querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      Timestamp dateAsTime = data["dateTime"];
      return Todo(
        id: data["id"],
        task: data["task"],
        description: data["description"],
        dateTime: dateAsTime.toDate(),
        isDone: data["isDone"],
      );
    }).where((todo) {
      if(todo.dateTime.year == selectedDate.year
          && todo.dateTime.month == selectedDate.month
          && todo.dateTime.day == selectedDate.day){
        return true;
      }else {return false ;}
    }).toList();
    print("todos: $todos");
    notifyListeners();
  }
}
