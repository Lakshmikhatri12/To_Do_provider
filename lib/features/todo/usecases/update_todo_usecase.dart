import 'package:fpdart/fpdart.dart';
import 'package:to_do_app/features/auth/failures/failure.dart';
import 'package:to_do_app/features/todo/entities/task_entity.dart';
import 'package:to_do_app/features/todo/repositories/todo_repository.dart';

class UpdateTodoUseCase {
  final TodoRepository repository;
  UpdateTodoUseCase(this.repository);

  Future<Either<Failure, TaskEntity?>> call(int id, TaskEntity data) =>
      repository.updateTodo(id, data);
}
