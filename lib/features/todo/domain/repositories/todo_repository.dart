import 'package:dartz/dartz.dart';
import 'package:to_do_app/core/error/failure.dart';
import 'package:to_do_app/features/todo/domain/entities/task_entity.dart';

abstract class TodoRepository {
  Future<Either<Failure, List<TaskEntity>>> getTodos();
  Future<Either<Failure, TaskEntity>> createTodo({
    required String title,
    String? description,
    String? category,
    int? priority,
    DateTime? dateTime,
  });
  Future<Either<Failure, TaskEntity?>> updateTodo(int id, TaskEntity data);
  Future<Either<Failure, void>> deleteTodo(int id);
}
