import 'package:fpdart/fpdart.dart';
import 'package:to_do_app/features/auth/failures/failure.dart';
import 'package:to_do_app/features/todo/repositories/todo_repository.dart';

class DeleteTodoUsecase {
  final TodoRepository repository;
  DeleteTodoUsecase(this.repository);

  Future<Either<Failure, void>> call(int id) => repository.deleteTodo(id);
}
