class Task {
  String? id;
  String? title;
  String? description;
  DateTime? dateTime;
  bool? isDone;

  Task(
      {required this.dateTime,
      required this.title,
      required this.description,
      this.isDone = false,
      this.id = '1'});

  Task.fromFireStore(Map<String, dynamic> data)
      : this(
            id: data['id'] as String?,
            title: data['title'] as String?,
            dateTime: DateTime.fromMillisecondsSinceEpoch(data['datetime'])
                as DateTime?,
            description: data['description'] as String?,
            isDone: data['isdone'] as bool?);

  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'title': title,
      'datetime': dateTime?.millisecondsSinceEpoch,
      'description': description,
      'isdone': isDone
    };
  }
}
