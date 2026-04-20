import 'package:flutter/material.dart';
import 'package:to_do_app/features/todo/entities/task_entity.dart';
import 'package:to_do_app/features/todo/models/create_todo_request.dart';
import 'package:to_do_app/features/todo/usecases/create_todo_usecase.dart';
import 'package:to_do_app/features/todo/usecases/delete_todo_usecase.dart';
import 'package:to_do_app/features/todo/usecases/get_todo_usecase.dart';
import 'package:to_do_app/features/todo/usecases/update_todo_usecase.dart';

enum TaskState { idle, loading, success, error }

class TaskViewModel extends ChangeNotifier {
  final GetTodoUseCase _getTodoUseCase;
  final CreateTodoUseCase _createTodoUseCase;
  final UpdateTodoUseCase _updateTodoUseCase;
  final DeleteTodoUseCase _deleteTodoUseCase;

  TaskViewModel(
    this._getTodoUseCase,
    this._createTodoUseCase,
    this._updateTodoUseCase,
    this._deleteTodoUseCase,
  );

  TaskState state = TaskState.idle;
  List<TaskEntity> tasks = [];
  String? errorMessage;

  Future<void> getTodos() async {
    // Only show full loading state on initial load, not on pull-to-refresh
    if (tasks.isEmpty) {
      state = TaskState.loading;
    }
    errorMessage = null;
    notifyListeners();

    final result = await _getTodoUseCase();
    result.fold(
      (failure) {
        state = TaskState.error;
        errorMessage = failure.message;
      },
      (data) {
        state = TaskState.success;
        tasks = data;
      },
    );
    notifyListeners();
  }

  Future<void> createTodo(
    String title, {
    String? description,
    String? category,
    int? priority,
    DateTime? dateTime,
  }) async {
    if (title.trim().isEmpty) return;

    state = TaskState.loading;
    notifyListeners();

    final request = CreateTodoRequest(
      title: title.trim(),
      description: description,
      completed: false,
      userId: 1,
      priority: priority ?? 0,
      category: category,
      dateTime: dateTime,
    );
    final result = await _createTodoUseCase(request);
    result.fold(
      (failure) {
        state = TaskState.error;
        errorMessage = failure.message;
        debugPrint('createTodo Failure: ${failure.message}');
      },
      (newTask) {
        state = TaskState.success;
        tasks = [newTask, ...tasks];
        debugPrint('Task created: ${newTask.title}');
      },
    );
    notifyListeners();
  }

  Future<void> toggleComplete(TaskEntity task) async {
    final updated = task.copyWith(completed: !task.completed);
    final idx = tasks.indexOf(task);
    tasks[idx] = updated;

    final result = await _updateTodoUseCase(task.id, updated);
    result.fold(
      (failure) {
        tasks[idx] = task;
        state = TaskState.error;
        errorMessage = failure.message;
        debugPrint('toggleComplete Failure: ${failure.message}');
      },
      (updated) {
        debugPrint('toggele completed');
      },
    );
    notifyListeners();
  }

  Future<void> updateTodo(TaskEntity task) async {
    final idx = tasks.indexWhere((t) => t.id == task.id);
    if (idx == -1) return;

    // Save the old task for rollback on failure
    final oldTask = tasks[idx];

    // Optimistically update the UI + show loading
    state = TaskState.loading;
    tasks[idx] = task;
    tasks = List.from(tasks);
    notifyListeners();

    final result = await _updateTodoUseCase(task.id, task);

    result.fold(
      (failure) {
        // Rollback to old task on failure
        tasks[idx] = oldTask;
        tasks = List.from(tasks);
        state = TaskState.error;
        errorMessage = failure.message;
        debugPrint('updateTodo Failure: ${failure.message}');
      },
      (_) {
        state = TaskState.success;
        debugPrint('Task Updated: ${task.title}');
      },
    );
    notifyListeners();
  }

  Future<void> deleteTodo(TaskEntity task) async {
    final idx = tasks.indexWhere((t) => t.id == task.id);
    if (idx == -1) return;
    final removedTask = tasks[idx];
    tasks.removeAt(idx);
    notifyListeners();

    final result = await _deleteTodoUseCase(task.id);
    result.fold(
      (failure) {
        tasks.insert(idx, removedTask);
        errorMessage = failure.message;
      },
      (_) {
        debugPrint("Task deleted");
      },
    );
    notifyListeners();
  }

  void resetState() {
    state = TaskState.idle;
    errorMessage = null;
    notifyListeners();
  }
}
