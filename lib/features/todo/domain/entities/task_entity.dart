import 'package:equatable/equatable.dart';
import 'package:hive_ce/hive.dart';

part 'task_entity.g.dart';

@HiveType(typeId: 0)
class TaskEntity extends Equatable {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final bool completed;
  @HiveField(4)
  final int priority;
  @HiveField(5)
  final String? category;
  @HiveField(6)
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

  @override
  // TODO: implement props
  List<Object?> get props =>
      [id, title, description, category, priority, dateTime];
}
