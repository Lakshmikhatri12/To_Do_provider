import 'package:equatable/equatable.dart';
import 'package:to_do_app/features/todo/domain/entities/task_entity.dart';

abstract class TodoState extends Equatable {
  const TodoState();
  @override
  List get props => [];
}

class InitTodoState extends TodoState {}

class LoadingTodoState extends TodoState {}

class ErrorTodoState extends TodoState {
  final String message;
  const ErrorTodoState(this.message);
  @override
  List get props => [message];
}

class ResponseTodoState extends TodoState {
  final List<TaskEntity> todo;

  const ResponseTodoState(this.todo);

  @override
  List get props => [todo];
}

class TodoUpdating extends TodoState {}
