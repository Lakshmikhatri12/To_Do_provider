import 'package:to_do_app/features/todo/models/task_model/task_model.dart';
import 'package:to_do_app/features/todo/repositories/todo_repository.dart';
import 'package:to_do_app/features/todo/services/todo_service.dart';

const int _kMaxRemoteTaskId = 200;

class TodoRepositoryImpl implements TodoRepository {
  final TodoService _todoService;

  TodoRepositoryImpl(this._todoService);

  @override
  Future<List<TaskModel>> getTodos() async {
    final response = await _todoService.getTodos();
    final List todos = response;
    return todos.map((e) => TaskModel.fromJson(e)).toList();
  }

  @override
  Future<TaskModel> createTodo(Map<String, dynamic> data) async {
    final response = await _todoService.createTodo(data);
    return TaskModel.fromJson(response);
  }

  @override
  Future<TaskModel?> updateTodo(int id, Map<String, dynamic> data) async {
    if (id > _kMaxRemoteTaskId) return TaskModel.fromJson(data);
    final response = await _todoService.updateTodo(id, data);
    return TaskModel.fromJson(response);
  }

  @override
  Future<void> deleteTodo(int id) async {
    if (id > _kMaxRemoteTaskId) return;
    await _todoService.deleteTodo(id);
  }
}
