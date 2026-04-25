import 'package:to_do_app/core/local/hive_service.dart';
import 'package:to_do_app/features/todo/entities/task_entity.dart';

class TodoService {
  final HiveService _hiveService;

  TodoService(this._hiveService);

  Future<dynamic> getTodos() async {
    return _hiveService.getAllTasks();
  }

  Future<dynamic> createTodo(TaskEntity task) async {
    await _hiveService.addTask(task: task);
    return task;
  }

  Future<dynamic> updateTodo(int id, TaskEntity task) async {
    await _hiveService.updateTask(task: task);
    return task;
  }

  Future<dynamic> deleteTodo(int id) async {
    return await _hiveService.deleteTask(id: id);
  }
}
