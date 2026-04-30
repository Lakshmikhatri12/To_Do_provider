import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:to_do_app/core/error/failure.dart';
import 'package:to_do_app/core/usecase/base_usecase.dart';
import 'package:to_do_app/features/todo/domain/entities/task_entity.dart';
import 'package:to_do_app/features/todo/domain/repositories/todo_repository.dart';

@injectable
class CreateTodoUseCase extends BaseUseCase<TaskEntity, CreateTodoParams> {
  final TodoRepository repository;
  CreateTodoUseCase(this.repository);

  @override
  Future<Either<Failure, TaskEntity>> call(CreateTodoParams params) {
    return repository.createTodo(
      title: params.title,
      description: params.description,
      category: params.category,
      priority: params.priority,
      dateTime: params.dateTime,
    );
  }
}

class CreateTodoParams {
  final String title;
  final String? description;
  final String? category;
  final int? priority;
  final DateTime? dateTime;

  const CreateTodoParams({
    required this.title,
    this.description,
    this.category,
    this.priority,
    this.dateTime,
  });
}
