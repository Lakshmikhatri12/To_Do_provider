import 'package:to_do_app/features/todo/entities/task_entity.dart';
import 'package:to_do_app/features/todo/repositories/todo_repository.dart';

class CreateTodoUsecase {
  final TodoRepository repository;

  CreateTodoUsecase(this.repository);

  Future<TaskEntity> call({
    required String title,
    String? description,
    String? category,
    int? priority = 0,
    DateTime? dateTime,
  }) async {
    if (title.trim().isEmpty) throw Exception('Title required');
    return await repository.createTodo(
      title: title.trim(),
      description: description,
      priority: priority ?? 0,
      category: category,
      dateTime: dateTime,
    );
  }
}
