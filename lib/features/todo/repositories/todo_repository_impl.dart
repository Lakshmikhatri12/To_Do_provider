import 'package:fpdart/fpdart.dart';
import 'package:to_do_app/features/auth/failures/failure.dart';
import 'package:to_do_app/features/todo/entities/task_entity.dart';
import 'package:to_do_app/features/todo/models/task_model/task_model.dart';
import 'package:to_do_app/features/todo/repositories/todo_repository.dart';
import 'package:to_do_app/features/todo/services/todo_service.dart';

const int _kMaxRemoteTaskId = 200;

class TodoRepositoryImpl implements TodoRepository {
  final TodoService _todoService;

  TodoRepositoryImpl(this._todoService);

  @override
  Future<Either<Failure, List<TaskEntity>>> getTodos() async {
    try {
      final response = await _todoService.getTodos();
      final List todos = response;
      final tasks = todos.map((e) => TaskModel.fromJson(e).toEntity()).toList();
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
      final data = {
        'title': title,
        'description': description,
        'category': category,
        'priority': priority,
        'dateTime': dateTime?.toIso8601String(),
      };
      final response = await _todoService.createTodo(data);
      final task = TaskModel.fromJson(response).toEntity();

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
      if (id > _kMaxRemoteTaskId) {
        return Right(data);
      }
      final body = {
        'title': data.title,
        'description': data.description,
        'completed': data.completed,
        'priority': data.priority,
        'category': data.category,
      };
      final response = await _todoService.updateTodo(id, body);
      final task = TaskModel.fromJson(response).toEntity();
      return Right(task);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTodo(int id) async {
    try {
      if (id > _kMaxRemoteTaskId) return Right(null);
      await _todoService.deleteTodo(id);
      return Right(null);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }
}
