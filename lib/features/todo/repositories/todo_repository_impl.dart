import 'package:to_do_app/features/todo/models/task_model.dart';
import 'package:to_do_app/features/todo/repositories/todo_repository.dart';
import 'package:to_do_app/features/todo/services/todo_service.dart';

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
  Future<TaskModel> updateTodo(int id, Map<String, dynamic> data) async {
    final response = await _todoService.updateTodo(id, data);
    return TaskModel.fromJson(response);
  }

  @override
  Future<void> deleteTodo(int id) async {
    await _todoService.deleteTodo(id);
  }
}
