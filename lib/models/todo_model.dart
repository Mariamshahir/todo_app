class Todo {
  static const String collectionName ="todo";
  String? id;
  String? task;
  String? description;
  DateTime? dateTime;
  bool? isDone;

  Todo({ this.id,
     this.task,
     this.description,
     this.dateTime,
     this.isDone});

}
