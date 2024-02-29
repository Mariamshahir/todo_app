import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo/models/todo_model.dart';

class ListProvider extends ChangeNotifier {
  List<Todo> todos = [];

  DateTime selectedDate = DateTime.now();

  onDateSelected(DateTime newDateTime) {
    selectedDate = newDateTime;
    refreshTodo();
    notifyListeners();
  }

  refreshTodo() async {
    todos.clear();
    CollectionReference todoCollection =
        FirebaseFirestore.instance.collection(Todo.collectionName);
    QuerySnapshot querySnapshot = await todoCollection.get();
    List<QueryDocumentSnapshot<Object?>> documentList = querySnapshot.docs;
    for (QueryDocumentSnapshot doc in documentList) {
      Map json = doc.data() as Map;
      Timestamp dateAsTimeStamp = json["dateTime"];
      Todo todo = Todo(
          id: json["id"],
          task: json["task"],
          description: json["description"],
          dateTime: dateAsTimeStamp.toDate(),
          isDone: json["isDone"]);
      if(selectedDate.year == todo.dateTime.year &&
          selectedDate.month == todo.dateTime.month &&
          selectedDate.day == todo.dateTime.day){
        todos.add(todo);
      }
    }
    // setState(() {});
    notifyListeners();
  }
}
