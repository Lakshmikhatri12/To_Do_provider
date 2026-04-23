import 'package:to_do_app/features/todo/entities/task_entity.dart';

abstract class TodoState {}

class InitTodoState extends TodoState {}

class LoadingTodoState extends TodoState {}

class ErrorTodoState extends TodoState {
  final String message;
  ErrorTodoState(this.message);
}

class ResponseTodoState extends TodoState {
  final List<TaskEntity> todo;
  ResponseTodoState(this.todo);
}

class TodoUpdating extends TodoState {}
