import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:to_do_app/core/error/exception.dart';
import 'package:to_do_app/core/network/client/api_service.dart';
import 'package:to_do_app/core/network/config/app_url.dart';
import 'package:to_do_app/features/todo/data/models/task_model/task_model.dart';
import 'package:to_do_app/features/todo/domain/entities/task_entity.dart';

abstract interface class TodoRemoteDataSource {
  Future<List<TaskEntity>> getTodos();
  Future<TaskEntity> createTodo(Map<String, dynamic> data);
  Future<TaskEntity> updateTodo(int id, Map<String, dynamic> data);
  Future<void> deleteTodo(int id);
}

@Injectable(as: TodoRemoteDataSource)
class TodoRemoteDataSourceImp implements TodoRemoteDataSource {
  final ApiService _apiService;
  TodoRemoteDataSourceImp(this._apiService);

  @override
  Future<TaskEntity> createTodo(Map<String, dynamic> data) async {
    try {
      final response = await _apiService.post(AppUrl.todosEndPoint, data: data);

      return TaskModel.fromJson(response).toEntity();
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'server error');
    }
  }

  @override
  Future<void> deleteTodo(int id) async {
    try {
      await _apiService.delete(AppUrl.todoById(id));
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'server error');
    }
  }

  @override
  Future<List<TaskEntity>> getTodos() async {
    try {
      final response = await _apiService.get(AppUrl.todosEndPoint);
      final List todos = response;
      return todos.map((e) => TaskModel.fromJson(e).toEntity()).toList();
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'server error');
    }
  }

  @override
  Future<TaskEntity> updateTodo(int id, Map<String, dynamic> data) async {
    try {
      final response = await _apiService.put(AppUrl.todoById(id), data: data);
      return TaskModel.fromJson(response).toEntity();
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'server error');
    }
  }
}
