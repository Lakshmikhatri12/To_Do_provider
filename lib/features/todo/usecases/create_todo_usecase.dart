import 'package:fpdart/fpdart.dart';
import 'package:to_do_app/features/auth/failures/failure.dart';
import 'package:to_do_app/features/todo/entities/task_entity.dart';
import 'package:to_do_app/features/todo/models/create_todo_request.dart';
import 'package:to_do_app/features/todo/repositories/todo_repository.dart';

class CreateTodoUseCase {
  final TodoRepository repository;
  CreateTodoUseCase(this.repository);

  Future<Either<Failure, TaskEntity>> call(CreateTodoRequest request) async {
    if (request.title.trim().isEmpty) {
      return Left(ValidationFailure('Title required'));
    }
    return repository.createTodo(
      title: request.title,
      description: request.description,
      priority: request.priority,
      category: request.category,
      dateTime: request.dateTime,
    );
  }
}
