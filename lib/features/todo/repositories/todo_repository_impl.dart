import 'package:fpdart/fpdart.dart';
import 'package:to_do_app/features/auth/failures/failure.dart';
import 'package:to_do_app/features/todo/entities/task_entity.dart';
import 'package:to_do_app/features/todo/repositories/todo_repository.dart';
import 'package:to_do_app/features/todo/services/todo_service.dart';
import 'package:uuid/uuid.dart';

const int _kMaxRemoteTaskId = 200;

class TodoRepositoryImpl implements TodoRepository {
  final TodoService _todoService;

  TodoRepositoryImpl(this._todoService);

  @override
  Future<Either<Failure, List<TaskEntity>>> getTodos() async {
    try {
      final tasks = await _todoService.getTodos();
      return Right(tasks);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, TaskEntity>> createTodo({
    required String title,
    String? description,
    String? category,
    int? priority,
    DateTime? dateTime,
  }) async {
    try {
      final data = TaskEntity(
        id: Uuid().v1().hashCode.abs(),
        title: title,
        description: description ?? '',
        completed: false,
        priority: priority ?? 0,
        category: category,
        dateTime: dateTime,
      );
      final task = await _todoService.createTodo(data);
      return Right(task);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, TaskEntity?>> updateTodo(
    int id,
    TaskEntity data,
  ) async {
    try {
      final response = await _todoService.updateTodo(id, data);
      return Right(response);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTodo(int id) async {
    try {
      await _todoService.deleteTodo(id);
      return Right(null);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }
}
