import 'package:to_do_app/features/todo/repositories/todo_repository.dart';

class DeleteTodoUsecase {
  final TodoRepository repository;

  DeleteTodoUsecase(this.repository);

  Future<void> call(int id) => repository.deleteTodo(id);
}
