class Todo {
  static const String collectionName ="todo";
  String id;
  String task;
  String description;
  DateTime dateTime;
  bool isDone;

  Todo({required this.id,
    required this.task,
    required this.description,
    required this.dateTime,
    required this.isDone});

}
