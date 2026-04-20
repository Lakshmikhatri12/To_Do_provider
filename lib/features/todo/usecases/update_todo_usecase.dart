import 'package:to_do_app/features/todo/entities/task_entity.dart';
import 'package:to_do_app/features/todo/repositories/todo_repository.dart';

class UpdateTodoUsecase {
  final TodoRepository repository;

  UpdateTodoUsecase(this.repository);

  Future<TaskEntity?> call(int id, TaskEntity data) =>
      repository.updateTodo(id, data);
}
