import 'package:to_do_app/features/todo/models/task_model.dart';

abstract class TodoRepository {
  Future<List<TaskModel>> getTodos();
  Future<TaskModel> createTodo(Map<String, dynamic> data);
  Future<TaskModel> updateTodo(int id, Map<String, dynamic> data);
  Future<void> deleteTodo(int id);
}
