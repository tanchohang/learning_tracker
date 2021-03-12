class TodoM {
  String id;
  String title;
  String deadline;
  List reminder;
  String description;
  String start;
  bool completed;
  bool archived;

  TodoM(
      {this.id,
      this.title,
      this.deadline,
      this.reminder,
      this.archived,
      this.completed,
      this.description,
      this.start});

  factory TodoM.fromJson(Map<String, dynamic> json) {
    return TodoM(
      id: json['id'],
      title: json['title'],
      deadline: json['deadline'],
      reminder: json['reminder'],
      start: json['start'],
      archived: json['archived'],
      completed: json['completed'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'deadline': deadline,
      'reminder': reminder,
      'archived': archived,
      'completed': completed,
      'start': start,
      'description': description,
    };
  }
}
