import 'package:flutter/material.dart';
import 'package:to_do_app/features/todo/models/create_todo_request.dart';
import 'package:to_do_app/features/todo/models/task_model/task_model.dart';
import 'package:to_do_app/features/todo/repositories/todo_repository.dart';

enum TaskState { idle, loading, success, error }

class TaskViewModel extends ChangeNotifier {
  final TodoRepository _taskrepo;

  TaskViewModel(this._taskrepo);

  TaskState state = TaskState.idle;
  List<TaskModel> tasks = [];
  String? errorMessage;

  // IconData? categoryIcon;
  // String? categoryLabel;
  // Color? categoryColor;
  // int selectedPriority = 1;
  //DateTime? selectedDateTime;

  Future<void> getTodos() async {
    state = TaskState.loading;
    errorMessage = null;
    notifyListeners();

    try {
      tasks = await _taskrepo.getTodos();
      state = TaskState.success;
      debugPrint('Tasks loaded: ${tasks.length}');
    } catch (e) {
      state = TaskState.error;
      errorMessage = 'Failed to load tasks. Please try again.';
      //  debugPrint('getTodos error: $e');
    } finally {
      notifyListeners();
    }
  }

  Future<void> createTodo(
    String title, {
    String? description,
    String? category,
    int? priority,
    DateTime? dateTime,
  }) async {
    if (title.trim().isEmpty) return;

    try {
      final request = CreateTodoRequest(
        title: title.trim(),
        description: description,
        completed: false,
        userId: 1,
        dateTime: dateTime,
        category: category,
        priority: priority ?? 0,
      );
      final newTask = await _taskrepo.createTodo(request.toJson());
      final updatedTask = newTask.copyWith(
        description: request.description!,
        priority: request.priority,
        category: request.category,
        dateTime: request.dateTime,
      );
      // final updatedTask = newTask.copyWith(
      //   description: description ?? '',
      //   priority: priority ?? 0,
      //   category: category,
      //   dateTime: dateTime,
      // );
      tasks.insert(0, updatedTask);
      //  debugPrint('Task created: ${updatedTask.title}');

      // _clearTaskState();
    } catch (e) {
      errorMessage = 'Failed to create task. Please try again.';
      //  debugPrint('createTodo error: $e');
    } finally {
      notifyListeners();
    }
  }

  Future<void> toggleComplete(TaskModel task) async {
    const int kMaxRemoteTaskId = 200;
    final updated = task.copyWith(completed: !task.completed);
    final idx = tasks.indexOf(task);
    tasks[idx] = updated;
    notifyListeners();

    try {
      if (task.id <= kMaxRemoteTaskId) {
        await _taskrepo.updateTodo(task.id, {'completed': !task.completed});
      }
      // debugPrint('Toggled: ${task.title}');
    } catch (e) {
      tasks[idx] = task;
      errorMessage = 'Failed to update task.';
      // debugPrint('toggleComplete error: $e');
      notifyListeners();
    }
  }

  Future<void> updateTodo(TaskModel task) async {
    const int kMaxRemoteTaskId = 200;
    state = TaskState.loading;
    notifyListeners();

    final idx = tasks.indexWhere((t) => t.id == task.id);
    if (idx != -1) {
      tasks[idx] = task;
    }

    try {
      if (task.id <= kMaxRemoteTaskId) {
        await _taskrepo.updateTodo(task.id, task.toJson());
      }
      //   debugPrint('Task updated: ${task.title}');
    } catch (e) {
      //   debugPrint('Update failed: $e');
    } finally {
      state = TaskState.idle;
      notifyListeners();
    }
  }

  Future<void> deleteTodo(TaskModel task) async {
    final idx = tasks.indexWhere((t) => t.id == task.id);
    if (idx == -1) return;
    final removedTask = tasks[idx];
    tasks.removeAt(idx);
    notifyListeners();

    try {
      await _taskrepo.deleteTodo(task.id);
      //   debugPrint('Task deleted: ${task.title}');
    } catch (e) {
      tasks.insert(idx, removedTask);
      errorMessage = 'Failed to delete task. Please try again.';
      notifyListeners();
    }
  }

  // void setDateTime(DateTime? dateTime) {
  //   selectedDateTime = dateTime;
  //   notifyListeners();
  // }

  // void _clearTaskState() {
  //   // categoryIcon = null;
  //   // categoryLabel = null;
  //   // categoryColor = null;
  //   // selectedPriority = 1;
  //   selectedDateTime = null;
  // }

  void resetState() {
    state = TaskState.idle;
    errorMessage = null;
    notifyListeners();
  }
}
