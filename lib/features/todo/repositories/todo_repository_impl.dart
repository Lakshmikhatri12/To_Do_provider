import 'package:to_do_app/features/todo/entities/task_entity.dart';
import 'package:to_do_app/features/todo/models/task_model/task_model.dart';
import 'package:to_do_app/features/todo/repositories/todo_repository.dart';
import 'package:to_do_app/features/todo/services/todo_service.dart';

const int _kMaxRemoteTaskId = 200;

class TodoRepositoryImpl implements TodoRepository {
  final TodoService _todoService;

  TodoRepositoryImpl(this._todoService);

  @override
  Future<List<TaskEntity>> getTodos() async {
    final response = await _todoService.getTodos();
    final List todos = response;
    return todos.map((e) => TaskModel.fromJson(e).toEntity()).toList();
  }

  @override
  Future<TaskEntity> createTodo({
    required String title,
    String? description,
    String? category,
    int? priority,
    DateTime? dateTime,
  }) async {
    final data = {
      'title': title,
      'description': description,
      'category': category,
      'priority': priority,
      'dateTime': dateTime?.toIso8601String(),
    };
    final response = await _todoService.createTodo(data);
    return TaskModel.fromJson(response).toEntity();
  }

  @override
  Future<void> deleteTodo(int id) async {
    if (id > _kMaxRemoteTaskId) return;
    await _todoService.deleteTodo(id);
  }

  @override
  Future<TaskEntity?> updateTodo(int id, TaskEntity data) async {
    if (id > _kMaxRemoteTaskId) {
      return data;
    }
    final body = {
      'title': data.title,
      'description': data.description,
      'completed': data.completed,
      'priority': data.priority,
      'category': data.category,
    };
    final response = await _todoService.updateTodo(id, body);
    return TaskModel.fromJson(response).toEntity();
  }
}
