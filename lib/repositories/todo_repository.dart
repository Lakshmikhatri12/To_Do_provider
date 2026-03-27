import 'package:to_do_app/core/constants/app_api.dart';
import 'package:to_do_app/data/network/base_api_services.dart';
import 'package:to_do_app/data/network/network_api_service.dart';
import 'package:to_do_app/model/taskModel.dart';

class ToDoRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<List<TaskModel>> getTodos() async {
    final response = await _apiServices.getGetApiResponse(AppUrl.todosEndPoint);
    // response is a List of Maps → convert each Map into a TaskModel
    return (response as List).map((e) => TaskModel.fromJson(e)).toList();
  }

  Future<TaskModel> createTodo(String title) async {
    final response = await _apiServices.getPostApiResponse(
      AppUrl.todosEndPoint,
      {"title": title, "complete": false, "userId": 1},
    );
    return TaskModel.fromJson(response);
  }

  Future<TaskModel> updateTodo(TaskModel task) async {
    final response = await _apiServices.getPutApiResponse(
      AppUrl.todoById(task.id!),
      task.toJson(),
    );
    return TaskModel.fromJson(response);
  }

  Future<void> deleteTodo(int id) async {
    // DELETE returns {} on success — we don't need to parse it
    await _apiServices.getDeleteApiResponse(AppUrl.todoById(id));
  }
}
