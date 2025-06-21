// lib/models/task.dart
class Task {
  String id;
  String title;
  String? description;
  DateTime? dueDate;
  bool isCompleted;

  Task({
    required this.id,
    required this.title,
    this.description,
    this.dueDate,
    this.isCompleted = false,
  });

  // Convert a Task object into a Map object
  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'dueDate': dueDate?.toIso8601String(), // Convert DateTime to String
    'isCompleted': isCompleted,
  };

  // Convert a Map object into a Task object
  factory Task.fromJson(Map<String, dynamic> json) => Task(
    id: json['id'],
    title: json['title'],
    description: json['description'],
    dueDate: json['dueDate'] != null ? DateTime.parse(json['dueDate']) : null,
    isCompleted: json['isCompleted'] ?? false, // Default to false if null
  );
}
