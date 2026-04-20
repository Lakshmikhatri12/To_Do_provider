// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:mockito/annotations.dart';
// import 'package:to_do_app/features/auth/failures/failure.dart';
// import 'package:to_do_app/features/todo/models/task_model/task_model.dart';
// import 'package:to_do_app/features/todo/repositories/todo_repository.dart';
// import 'package:to_do_app/features/todo/view_models/task_view_model.dart';
// import 'todo_viewmodel_test.mocks.dart';
//
// @GenerateMocks([TodoRepository])
// void main() {
//   late MockTodoRepository mockTodoRepo;
//   late TaskViewModel taskViewModel;
//
//   final testTask = TaskModel(
//     id: 1,
//     title: 'Test Task',
//     description: 'This is a test task',
//     category: 'Test',
//     completed: false,
//     priority: 1,
//   );
//
//   setUp(() {
//     mockTodoRepo = MockTodoRepository();
//     taskViewModel = TaskViewModel(mockTodoRepo);
//   });
//
//   group('Get Todos', () {
//     test('on success: tasks loaded', () async {
//       when(mockTodoRepo.getTodos()).thenAnswer((_) async => [testTask]);
//       await taskViewModel.getTodos();
//       expect(taskViewModel.state, TaskState.success);
//       expect(taskViewModel.tasks.length, 1);
//       expect(taskViewModel.tasks.first.title, 'Test Task');
//     });
//
//     test('on failure: failed to load tasks', () async {
//       when(
//         mockTodoRepo.getTodos(),
//       ).thenThrow(ServerFailure('No internet connection'));
//
//       await taskViewModel.getTodos();
//       expect(taskViewModel.state, TaskState.error);
//       expect(taskViewModel.errorMessage, 'No internet connection');
//     });
//   });
//
//   group('Create Todo', () {
//     test("Task created successfully", () async {
//       when(mockTodoRepo.createTodo(any)).thenAnswer((_) async => testTask);
//       await taskViewModel.createTodo(testTask.title);
//
//       expect(taskViewModel.tasks.length, 1);
//       expect(taskViewModel.tasks.first.title, 'Test Task');
//       expect(taskViewModel.state, TaskState.idle);
//     });
//
//     test('on failure: failed to create task', () async {
//       when(
//         mockTodoRepo.createTodo(any),
//       ).thenThrow(ServerFailure('something went wrong'));
//
//       await taskViewModel.createTodo(testTask.title);
//
//       expect(taskViewModel.state, TaskState.error);
//       expect(taskViewModel.errorMessage, 'something went wrong');
//     });
//   });
//   group('toggel complete', () {
//     test('Task completed', () async {
//       taskViewModel.tasks.add(testTask);
//       when(mockTodoRepo.updateTodo(any, any)).thenAnswer((_) async => testTask);
//
//       await taskViewModel.toggleComplete(testTask);
//       expect(taskViewModel.tasks.first.completed, true);
//     });
//
//     test('Failed - rollback', () async {
//       taskViewModel.tasks.add(testTask);
//       when(
//         mockTodoRepo.updateTodo(any, any),
//       ).thenThrow(ServerFailure('Server error'));
//
//       await taskViewModel.toggleComplete(testTask);
//
//       expect(taskViewModel.tasks.first.completed, false);
//       expect(taskViewModel.state, TaskState.error);
//     });
//   });
//
//   group('delete Todo', () {
//     test('Task deleted', () async {
//       taskViewModel.tasks.add(testTask);
//       when(mockTodoRepo.deleteTodo(any)).thenAnswer((_) async => {});
//
//       await taskViewModel.deleteTodo(testTask);
//
//       expect(taskViewModel.tasks.length, 0);
//     });
//
//     test('Failed to delete', () async {
//       taskViewModel.tasks.add(testTask);
//       when(
//         mockTodoRepo.deleteTodo(any),
//       ).thenThrow(ServerFailure('Server Failure'));
//
//       await taskViewModel.deleteTodo(testTask);
//
//       expect(taskViewModel.state, TaskState.error);
//       expect(taskViewModel.tasks.length, 1);
//       expect(taskViewModel.errorMessage, 'Server Failure');
//     });
//   });
//   group('update Todo', () {
//     test('Task updated', () async {
//       taskViewModel.tasks.add(testTask);
//       final updatedTask = testTask.copyWith(title: 'Updated Title');
//       when(mockTodoRepo.updateTodo(any, any)).thenAnswer((_) async => testTask);
//
//       await taskViewModel.updateTodo(updatedTask);
//
//       expect(taskViewModel.tasks.first.title, 'Updated Title');
//     });
//
//     test('Failed to update', () async {
//       taskViewModel.tasks.add(testTask);
//       final updatedTask = testTask.copyWith(title: 'Updated Title');
//       when(
//         mockTodoRepo.updateTodo(any, any),
//       ).thenThrow(ServerFailure('Server Failure'));
//
//       await taskViewModel.updateTodo(updatedTask);
//
//       expect(taskViewModel.state, TaskState.error);
//       expect(taskViewModel.errorMessage, 'Server Failure');
//     });
//   });
// }
