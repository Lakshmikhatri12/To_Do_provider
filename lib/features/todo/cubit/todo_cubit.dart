import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/features/todo/entities/task_entity.dart';
import 'package:to_do_app/features/todo/models/create_todo_request.dart';
import 'package:to_do_app/features/todo/cubit/todo_state.dart';
import 'package:to_do_app/features/todo/usecases/create_todo_usecase.dart';
import 'package:to_do_app/features/todo/usecases/delete_todo_usecase.dart';
import 'package:to_do_app/features/todo/usecases/get_todo_usecase.dart';
import 'package:to_do_app/features/todo/usecases/update_todo_usecase.dart';

class TodoCubit extends Cubit<TodoState> {
  final GetTodoUseCase _getTodoUseCase;
  final CreateTodoUseCase _createTodoUseCase;
  final UpdateTodoUseCase _updateTodoUseCase;
  final DeleteTodoUseCase _deleteTodoUseCase;

  TodoCubit(
    this._getTodoUseCase,
    this._createTodoUseCase,
    this._updateTodoUseCase,
    this._deleteTodoUseCase,
  ) : super(InitTodoState());

  List<TaskEntity> tasks = [];

  Future<void> getTodos() async {
    emit(LoadingTodoState());
    final result = await _getTodoUseCase();
    result.fold(
      (failure) {
        emit(ErrorTodoState(failure.message));
      },
      (data) {
        emit(ResponseTodoState(data));
        tasks = data;
      },
    );
  }

  Future<void> createTodo(
    String title, {
    String? description,
    String? category,
    int? priority,
    DateTime? dateTime,
  }) async {
    if (title.trim().isEmpty) return;

    emit(LoadingTodoState());

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
        emit(ErrorTodoState(failure.message));
        debugPrint('createTodo Failure: ${failure.message}');
      },
      (newTask) {
        tasks = [newTask, ...tasks];
        emit(ResponseTodoState(tasks));
        debugPrint('Task created: ${newTask.title}');
      },
    );
  }

  Future<void> toggleComplete(TaskEntity task) async {
    final updated = task.copyWith(completed: !task.completed);
    final idx = tasks.indexOf(task);
    tasks[idx] = updated;
    emit(ResponseTodoState(tasks));

    final result = await _updateTodoUseCase(task.id, updated);
    result.fold(
      (failure) {
        tasks[idx] = task;
        emit(ErrorTodoState(failure.message));
        debugPrint('toggleComplete Failure: ${failure.message}');
      },
      (updated) {
        debugPrint('toggele completed');
      },
    );
  }

  Future<void> updateTodo(TaskEntity task) async {
    final idx = tasks.indexWhere((t) => t.id == task.id);
    if (idx == -1) return;

    // Save the old task for rollback on failure
    final oldTask = tasks[idx];

    // Optimistically update the UI + show loading
    emit(TodoUpdating());
    tasks[idx] = task;
    tasks = List.from(tasks);

    final result = await _updateTodoUseCase(task.id, task);

    result.fold(
      (failure) {
        // Rollback to old task on failure
        tasks[idx] = oldTask;
        tasks = List.from(tasks);
        emit(ErrorTodoState(failure.message));
        debugPrint('updateTodo Failure: ${failure.message}');
      },
      (_) {
        emit(ResponseTodoState(tasks));
        debugPrint('Task Updated: ${task.title}');
      },
    );
  }

  Future<void> deleteTodo(TaskEntity task) async {
    final idx = tasks.indexWhere((t) => t.id == task.id);
    if (idx == -1) return;
    final removedTask = tasks[idx];
    tasks.removeAt(idx);
    emit(ResponseTodoState(tasks));

    final result = await _deleteTodoUseCase(task.id);
    result.fold(
      (failure) {
        tasks.insert(idx, removedTask);
        emit(ErrorTodoState(failure.message));
      },
      (_) {
        debugPrint("Task deleted");
      },
    );
  }

  void resetState() {
    emit(InitTodoState());
  }
}
