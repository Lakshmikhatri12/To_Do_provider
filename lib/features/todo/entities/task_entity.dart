class TaskEntity {
  final int id;
  final String title;
  final String description;
  final bool completed;
  final int priority;
  final String? category;
  final DateTime? dateTime;

  TaskEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.completed,
    required this.priority,
    this.category,
    this.dateTime,
  });

  TaskEntity copyWith({
    int? id,
    String? title,
    String? description,
    bool? completed,
    int? priority,
    String? category,
    DateTime? dateTime,
  }) {
    return TaskEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      completed: completed ?? this.completed,
      priority: priority ?? this.priority,
      category: category ?? this.category,
      dateTime: dateTime ?? this.dateTime,
    );
  }
}
