class CreateTodoRequest {
  final String title;
  final String? description;
  final bool completed;
  final int userId;
  final int priority;
  final String? category;
  final DateTime? dateTime;

  CreateTodoRequest({
    required this.title,
    this.description,
    required this.completed,
    required this.userId,
    this.priority = 0,
    this.category,
    this.dateTime,
  });

  Map<String, dynamic> toJson() => {
    'title': title,
    'todo': title,
    'description': description,
    'completed': completed,
    'priority': priority,
    'userId': userId,
    'category': category,
    'dateTime': dateTime?.toIso8601String(),
  };
}
