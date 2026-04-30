import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:to_do_app/core/error/exception.dart';
import 'package:to_do_app/core/local/hive_service.dart';
import 'package:to_do_app/features/todo/domain/entities/task_entity.dart';

abstract class TodoLocalDataSource {
  List<TaskEntity> getTodos();
  Future<TaskEntity> createTodo(TaskEntity task);
  Future<TaskEntity> updateTodo(TaskEntity task);
  Future<void> deleteTodo(int id);
}

@Injectable(as: TodoLocalDataSource)
class TodoLocalDataSourceImp implements TodoLocalDataSource {
  final HiveService _hiveService;
  TodoLocalDataSourceImp(this._hiveService);
  @override
  List<TaskEntity> getTodos() {
    try {
      return _hiveService.getAllTasks();
    } on DioException catch (e) {
      throw CacheException('cache error: $e');
    }
  }

  @override
  Future<TaskEntity> createTodo(TaskEntity task) async {
    try {
      await _hiveService.addTask(task: task);
      return task;
    } on DioException catch (e) {
      throw CacheException('cache error: $e');
    }
  }

  @override
  Future<void> deleteTodo(int id) {
    try {
      return _hiveService.deleteTask(id: id);
    } on DioException catch (e) {
      throw CacheException('cache error: $e');
    }
  }

  @override
  Future<TaskEntity> updateTodo(TaskEntity task) async {
    try {
      await _hiveService.updateTask(task: task);
      return task;
    } on DioException catch (e) {
      throw CacheException('cache error: $e');
    }
  }
}
