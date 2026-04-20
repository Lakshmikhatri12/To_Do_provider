import 'package:to_do_app/features/todo/entities/task_entity.dart';
import 'package:to_do_app/features/todo/repositories/todo_repository.dart';

class GetTodoUsecase {
  final TodoRepository repository;

  GetTodoUsecase(this.repository);

  Future<List<TaskEntity>> call() => repository.getTodos();
}
