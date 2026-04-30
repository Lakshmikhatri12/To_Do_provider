import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:to_do_app/core/error/failure.dart';
import 'package:to_do_app/core/usecase/base_usecase.dart';
import 'package:to_do_app/features/todo/domain/entities/task_entity.dart';
import 'package:to_do_app/features/todo/domain/repositories/todo_repository.dart';

@injectable
class UpdateTodoUseCase extends BaseUseCase<TaskEntity?, UpdateTodoParams> {
  final TodoRepository repository;
  UpdateTodoUseCase(this.repository);

  @override
  Future<Either<Failure, TaskEntity?>> call(UpdateTodoParams params) {
    return repository.updateTodo(params.id, params.task);
  }
}

class UpdateTodoParams {
  final TaskEntity task;
  final int id;
  const UpdateTodoParams({required this.task, required this.id});
}
