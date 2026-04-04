class TaskModel {
  final int id;
  final String title;
  final String description;
  final bool completed;
  final int priority;
  final String? category;
  DateTime? dateTime;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.completed,
    required this.priority,
    this.category,
    this.dateTime,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] is String
          ? int.tryParse(json['id']) ?? 0
          : json['id'] ?? 0,
      title: json['title'] ?? json['todo'] ?? '',
      description: json['description'] ?? '',
      completed: json['completed'] ?? false,
      priority: json['priority'] ?? 1,
      category: json['category'],
      dateTime: json['dateTime'],
    );
  }

  TaskModel copyWith({
    int? id,
    String? title,
    String? description,
    bool? completed,
    int? priority,
    String? category,
    DateTime? dateTime,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      completed: completed ?? this.completed,
      priority: priority ?? this.priority,
      category: category ?? this.category,
      dateTime: dateTime ?? this.dateTime,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'todo': title,
    'description': description,
    'completed': completed,
    'priority': priority,
    'category': category,
    'dateTime': dateTime,
  };
}
