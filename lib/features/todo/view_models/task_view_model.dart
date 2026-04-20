import 'package:flutter/material.dart';
import 'package:to_do_app/features/todo/entities/task_entity.dart';
import 'package:to_do_app/features/todo/models/create_todo_request.dart';
import 'package:to_do_app/useCases/create_todo_usecase.dart';
import 'package:to_do_app/useCases/delete_todo_usecase.dart';
import 'package:to_do_app/useCases/get_todo_usecase.dart';
import 'package:to_do_app/useCases/update_todo_usecase.dart';

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

    final result = await _getTodoUsecase();
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
    final request = CreateTodoRequest(
      title: title.trim(),
      description: description,
      completed: false,
      userId: 1,
      priority: priority ?? 0,
      category: category,
      dateTime: dateTime,
    );
    final result = await _createTodoUsecase(request);
    result.fold(
      (failure) {
        state = TaskState.error;
        errorMessage = failure.message;
        debugPrint('createTodo Failure: ${failure.message}');
      },
      (newTask) {
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

    final result = await _updateTodoUsecase(task.id, updated);
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
    state = TaskState.loading;
    notifyListeners();

    final idx = tasks.indexWhere((t) => t.id == task.id);
    if (idx != -1) {
      tasks[idx] = task;
      tasks = List.from(tasks);
      notifyListeners();
    }
    final result = await _updateTodoUsecase(task.id, task);

    result.fold(
      (failure) {
        tasks = List.from(tasks);
        errorMessage = failure.message;
      },
      (_) {
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

    final result = await _deleteTodoUsecase(task.id);
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
