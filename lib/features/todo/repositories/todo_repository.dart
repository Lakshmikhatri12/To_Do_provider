import 'package:to_do_app/features/todo/entities/task_entity.dart';

abstract class TodoRepository {
  Future<List<TaskEntity>> getTodos();
  Future<TaskEntity> createTodo({
    required String title,
    String? description,
    String? category,
    int? priority,
    DateTime? dateTime,
  });
  Future<TaskEntity?> updateTodo(int id, TaskEntity data);
  Future<void> deleteTodo(int id);
}
