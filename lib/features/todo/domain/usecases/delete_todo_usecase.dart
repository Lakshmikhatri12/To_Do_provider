import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:to_do_app/core/error/failure.dart';
import 'package:to_do_app/core/usecase/base_usecase.dart';
import 'package:to_do_app/features/todo/domain/repositories/todo_repository.dart';

@injectable
class DeleteTodoUseCase extends BaseUseCase<void, DeleteTodoParams> {
  final TodoRepository repository;
  DeleteTodoUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(DeleteTodoParams params) {
    return repository.deleteTodo(params.id);
  }

  //Future<Either<Failure, void>> call(int id) => repository.deleteTodo(id);
}

class DeleteTodoParams {
  final int id;
  const DeleteTodoParams({required this.id});
}
