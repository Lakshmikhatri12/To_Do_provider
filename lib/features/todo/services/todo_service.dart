import 'package:to_do_app/core/network/config/app_url.dart';
import 'package:to_do_app/core/network/client/api_service.dart';

class TodoService {
  final ApiService _apiService;

  TodoService(this._apiService);

  Future<dynamic> getTodos() async {
    return await _apiService.get(AppUrl.todosEndPoint);
  }

  Future<dynamic> createTodo(Map<String, dynamic> data) async {
    return await _apiService.post(AppUrl.todosEndPoint, data: data);
  }

  Future<dynamic> updateTodo(int id, Map<String, dynamic> data) async {
    return await _apiService.put(AppUrl.todoById(id), data: data);
  }

  Future<dynamic> deleteTodo(int id) async {
    return await _apiService.delete(AppUrl.todoById(id));
  }
}
