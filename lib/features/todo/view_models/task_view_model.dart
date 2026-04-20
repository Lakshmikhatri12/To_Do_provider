import 'package:flutter/material.dart';
import 'package:to_do_app/features/auth/failures/failure.dart';
import 'package:to_do_app/features/todo/entities/task_entity.dart';
import 'package:to_do_app/features/todo/usecases/create_todo_usecase.dart';
import 'package:to_do_app/features/todo/usecases/delete_todo_usecase.dart';
import 'package:to_do_app/features/todo/usecases/get_todo_usecase.dart';
import 'package:to_do_app/features/todo/usecases/update_todo_usecase.dart';

enum TaskState { idle, loading, success, error }

class TaskViewModel extends ChangeNotifier {
  final GetTodoUsecase _getTodoUsecase;
  final CreateTodoUsecase _createTodoUsecase;
  final UpdateTodoUsecase _updateTodoUsecase;
  final DeleteTodoUsecase _deleteTodoUsecase;

  TaskViewModel(
    this._getTodoUsecase,
    this._createTodoUsecase,
    this._updateTodoUsecase,
    this._deleteTodoUsecase,
  );

  TaskState state = TaskState.idle;
  List<TaskEntity> tasks = [];
  String? errorMessage;

  Future<void> getTodos() async {
    state = TaskState.loading;
    errorMessage = null;
    notifyListeners();

    try {
      tasks = await _getTodoUsecase();
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
      final newTask = await _createTodoUsecase(
        title: title,
        description: description,
        priority: priority,
        category: category,
        dateTime: dateTime,
      );

      tasks.insert(0, newTask);

      debugPrint('Task create: ${newTask.title}');
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

  Future<void> toggleComplete(TaskEntity task) async {
    final updated = task.copyWith(completed: !task.completed);
    final idx = tasks.indexOf(task);
    tasks[idx] = updated;

    try {
      await _updateTodoUsecase(task.id, updated);
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

  Future<void> updateTodo(TaskEntity task) async {
    state = TaskState.loading;
    notifyListeners();

    final idx = tasks.indexWhere((t) => t.id == task.id);
    if (idx != -1) {
      tasks[idx] = task;
      tasks = List.from(tasks);
      notifyListeners();
    }
    try {
      await _updateTodoUsecase(task.id, task);
      state = TaskState.success;
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

  Future<void> deleteTodo(TaskEntity task) async {
    final idx = tasks.indexWhere((t) => t.id == task.id);
    if (idx == -1) return;
    final removedTask = tasks[idx];
    tasks.removeAt(idx);
    notifyListeners();

    try {
      await _deleteTodoUsecase(task.id);
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
