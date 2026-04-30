import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:to_do_app/core/error/failure.dart';
import 'package:to_do_app/core/usecase/base_usecase.dart';
import 'package:to_do_app/features/todo/domain/entities/task_entity.dart';
import 'package:to_do_app/features/todo/domain/repositories/todo_repository.dart';

@injectable
class GetTodoUseCase extends BaseUseCase<List<TaskEntity>, NoParams> {
  final TodoRepository repository;
  GetTodoUseCase(this.repository);

  @override
  Future<Either<Failure, List<TaskEntity>>> call(NoParams params) {
    return repository.getTodos();
  }
}
