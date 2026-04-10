import 'package:freezed_annotation/freezed_annotation.dart';
part 'task_model.freezed.dart';
part 'task_model.g.dart';

@freezed
abstract class TaskModel with _$TaskModel {
  const factory TaskModel({
    @Default(0) int id,
    @Default('') String title,
    @Default('') String description,
    @Default(false) bool completed,
    @Default(0) int priority,
    String? category,
    DateTime? dateTime,
  }) = _TaskModel;

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);
}

// class TaskModel {
//   final int id;
//   final String title;
//   final String description;
//   final bool completed;
//   final int priority;
//   final String? category;
//   final DateTime? dateTime;

//   TaskModel({
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.completed,
//     required this.priority,
//     this.category,
//     this.dateTime,
//   });

//   factory TaskModel.fromJson(Map<String, dynamic> json) {
//     return TaskModel(
//       id: json['id'] is String
//           ? int.tryParse(json['id']) ?? 0
//           : json['id'] ?? 0,
//       title: json['title'] ?? json['todo'] ?? '',
//       description: json['description'] ?? '',
//       completed: json['completed'] ?? false,
//       priority: json['priority'] ?? 1,
//       category: json['category'],
//       dateTime: json['dateTime'],
//     );
//   }

//   TaskModel copyWith({
//     int? id,
//     String? title,
//     String? description,
//     bool? completed,
//     int? priority,
//     String? category,
//     DateTime? dateTime,
//   }) {
//     return TaskModel(
//       id: id ?? this.id,
//       title: title ?? this.title,
//       description: description ?? this.description,
//       completed: completed ?? this.completed,
//       priority: priority ?? this.priority,
//       category: category ?? this.category,
//       dateTime: dateTime ?? this.dateTime,
//     );
//   }

//   Map<String, dynamic> toJson() => {
//     'id': id,
//     'todo': title,
//     'description': description,
//     'completed': completed,
//     'priority': priority,
//     'category': category,
//     'dateTime': dateTime,
//   };
// }
