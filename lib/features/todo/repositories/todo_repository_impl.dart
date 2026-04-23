import 'package:fpdart/fpdart.dart';
import 'package:to_do_app/core/local/hive_service.dart';
import 'package:to_do_app/features/auth/failures/failure.dart';
import 'package:to_do_app/features/todo/entities/task_entity.dart';
import 'package:to_do_app/features/todo/models/task_model/task_model.dart';
import 'package:to_do_app/features/todo/repositories/todo_repository.dart';
import 'package:to_do_app/features/todo/services/todo_service.dart';

const int _kMaxRemoteTaskId = 200;

class TodoRepositoryImpl implements TodoRepository {
  final HiveService _hiveService;
  final TodoService _todoService;

  TodoRepositoryImpl(this._todoService, this._hiveService);

  @override
  Future<Either<Failure, List<TaskEntity>>> getTodos() async {
    try {
      List<TaskEntity> localTasks = _hiveService.getAllTasks();

      if (localTasks.isEmpty) {
        final response = await _todoService.getTodos();

        final List todos = response;
        final tasks = todos
            .map((e) => TaskModel.fromJson(e).toEntity())
            .toList();
        await _hiveService.saveTasks(tasks);
      }

      return Right(localTasks);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      final local = _hiveService.getAllTasks();
      if (local.isNotEmpty) return Right(local);
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
      var task = TaskModel.fromJson(response).toEntity();

      await _hiveService.addTask(task: task);

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
      if (id < _kMaxRemoteTaskId) {
        final body = {
          'title': data.title,
          'description': data.description,
          'completed': data.completed,
          'priority': data.priority,
          'category': data.category,
        };
        await _todoService.updateTodo(id, body);
      }

      await _hiveService.updateTask(task: data);
      return Right(data);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTodo(int id) async {
    try {
      await _hiveService.deleteTask(id: id);

      if (id < _kMaxRemoteTaskId) {
        await _todoService.deleteTodo(id);
      }

      return Right(null);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }
}
