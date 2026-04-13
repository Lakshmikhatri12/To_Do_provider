import 'package:flutter/material.dart';
import 'package:to_do_app/features/auth/failures/failure.dart';
import 'package:to_do_app/features/todo/models/create_todo_request.dart';
import 'package:to_do_app/features/todo/models/task_model/task_model.dart';
import 'package:to_do_app/features/todo/repositories/todo_repository.dart';

enum TaskState { idle, loading, success, error }

class TaskViewModel extends ChangeNotifier {
  final TodoRepository _taskRepo;

  TaskViewModel(this._taskRepo);

  TaskState state = TaskState.idle;
  List<TaskModel> tasks = [];
  String? errorMessage;

  Future<void> getTodos() async {
    state = TaskState.loading;
    errorMessage = null;
    notifyListeners();

    try {
      tasks = await _taskRepo.getTodos();
      state = TaskState.success;
    } on Failure catch (e) {
      state = TaskState.error;
      errorMessage = e.message;
      debugPrint('createTodo Failure: ${e.message}');
    } on Exception catch (e, stackTrace) {
      state = TaskState.error;
      errorMessage = 'Failed to create task. Please try again.';
      debugPrint('createTodo Exception: $e\n$stackTrace');
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
      final newTask = await _taskRepo.createTodo(request.toJson());
      final updatedTask = newTask.copyWith(
        description: request.description ?? '',
        priority: request.priority,
        category: request.category,
        dateTime: request.dateTime,
      );
      tasks.insert(0, updatedTask);
      debugPrint('Task create: ${updatedTask.title}');
    } on Failure catch (e) {
      state = TaskState.error;
      errorMessage = e.message;
      debugPrint('createTodo Failure: ${e.message}');
    } on Exception catch (e, stackTrace) {
      state = TaskState.error;
      errorMessage = 'Failed to create task. Please try again.';
      debugPrint('createTodo Exception: $e\n$stackTrace');
    } finally {
      notifyListeners();
    }
  }

  Future<void> toggleComplete(TaskModel task) async {
    final updated = task.copyWith(completed: !task.completed);
    final idx = tasks.indexOf(task);
    tasks[idx] = updated;

    try {
      await _taskRepo.updateTodo(task.id, {'completed': !task.completed});
    } on Failure catch (e) {
      tasks[idx] = task;
      state = TaskState.error;
      errorMessage = e.message;
      debugPrint('toggleComplete Failure: ${e.message}');
    } on Exception catch (e, stackTrace) {
      tasks[idx] = task;
      state = TaskState.error;
      errorMessage = 'Failed to update task. Please try again.';
      debugPrint('toggleComplete Exception: $e\n$stackTrace');
    } finally {
      notifyListeners();
    }
  }

  Future<void> updateTodo(TaskModel task) async {
    state = TaskState.loading;
    notifyListeners();

    final idx = tasks.indexWhere((t) => t.id == task.id);
    if (idx != -1) {
      tasks[idx] = task;
    }
    try {
      await _taskRepo.updateTodo(task.id, task.toJson());
      debugPrint('Task updated: ${task.title}');
    } on Failure catch (e) {
      state = TaskState.error;
      errorMessage = e.message;
      debugPrint('updateTodo Failure: ${e.message}');
    } on Exception catch (e, stackTrace) {
      state = TaskState.error;
      errorMessage = 'Failed to update task. Please try again.';
      debugPrint('updateTodo Exception: $e\n$stackTrace');
    } finally {
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
      await _taskRepo.deleteTodo(task.id);
      debugPrint('Task deleted: ${task.title}');
    } on Failure catch (e) {
      tasks[idx] = task;
      state = TaskState.error;
      errorMessage = e.message;
      debugPrint('deleteTodo Failure: ${e.message}');
    } on Exception catch (e, stackTrace) {
      tasks.insert(idx, removedTask);
      state = TaskState.error;
      errorMessage = 'Failed to delete task. Please try again.';
      debugPrint('deleteTodo Exception: $e\n$stackTrace');
    } finally {
      notifyListeners();
    }
  }

  void resetState() {
    state = TaskState.idle;
    errorMessage = null;
    notifyListeners();
  }
}
