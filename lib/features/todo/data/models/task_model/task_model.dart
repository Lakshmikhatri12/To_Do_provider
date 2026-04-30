import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:to_do_app/features/todo/domain/entities/task_entity.dart';
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

extension TaskModelMapper on TaskModel {
  TaskEntity toEntity() => TaskEntity(
    id: id,
    title: title,
    description: description,
    completed: completed,
    priority: priority,
    dateTime: dateTime,
    category: category,
  );
}
