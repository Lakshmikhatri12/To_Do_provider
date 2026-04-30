import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:to_do_app/core/error/failure.dart';
import 'package:to_do_app/features/todo/data/datasources/todo_local_data_source.dart';
import 'package:to_do_app/features/todo/data/datasources/todo_remote_data_source.dart';
import 'package:to_do_app/features/todo/domain/entities/task_entity.dart';
import 'package:to_do_app/features/todo/domain/repositories/todo_repository.dart';

const int _kMaxRemoteTaskId = 200;

@Injectable(as: TodoRepository)
class TodoRepositoryImpl implements TodoRepository {
  final TodoRemoteDataSource todoRemoteDataSource;
  final TodoLocalDataSource todoLocalDataSource;

  TodoRepositoryImpl(this.todoRemoteDataSource, this.todoLocalDataSource);

  @override
  Future<Either<Failure, List<TaskEntity>>> getTodos() async {
    try {
      final tasks = await todoRemoteDataSource.getTodos();
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
      final task = await todoRemoteDataSource.createTodo(data);
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
      final response = await todoRemoteDataSource.updateTodo(id, body);
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
      await todoRemoteDataSource.deleteTodo(id);
      return Right(null);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }
}
