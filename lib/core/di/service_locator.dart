// import 'package:dio/dio.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:get_it/get_it.dart';
// import 'package:to_do_app/core/local/hive_service.dart';
// import 'package:to_do_app/core/network/client/api_service.dart';
// import 'package:to_do_app/features/auth/repositories/auth_repository.dart';
// import 'package:to_do_app/features/auth/repositories/auth_repository_impl.dart';
// import 'package:to_do_app/features/auth/services/auth_service.dart';
// import 'package:to_do_app/features/auth/services/token_service.dart';
// import 'package:to_do_app/features/auth/view_models/auth_view_model.dart';
// import 'package:to_do_app/features/onboarding/view_models/onboarding_view_model.dart';
// import 'package:to_do_app/features/splash/view_models/splash_view_model.dart';
// import 'package:to_do_app/features/todo/data/datasources/todo_local_data_source.dart';
// import 'package:to_do_app/features/todo/data/datasources/todo_remote_data_source.dart';
// import 'package:to_do_app/features/todo/presentation/cubit/todo_cubit.dart';
// import 'package:to_do_app/features/todo/domain/repositories/todo_repository.dart';
// import 'package:to_do_app/features/todo/data/repositories/todo_repository_impl.dart';

// import '../../features/todo/domain/usecases/create_todo_usecase.dart';
// import '../../features/todo/domain/usecases/delete_todo_usecase.dart';
// import '../../features/todo/domain/usecases/get_todo_usecase.dart';
// import '../../features/todo/domain/usecases/update_todo_usecase.dart';

// final getIt = GetIt.instance;

// void setupLocator() {
//   getIt.registerLazySingleton<Dio>(() => Dio());

//   getIt.registerLazySingleton<FlutterSecureStorage>(
//     () => const FlutterSecureStorage(),
//   );

//   getIt.registerLazySingleton<TokenService>(
//     () => TokenService(getIt<FlutterSecureStorage>()),
//   );

//   getIt.registerLazySingleton<ApiService>(
//     () => ApiService(getIt<Dio>(), getIt<FlutterSecureStorage>()),
//   );

//   getIt.registerLazySingleton<HiveService>(() => HiveService());

//   getIt.registerLazySingleton<AuthService>(
//     () => AuthService(getIt<ApiService>()),
//   );

//   getIt.registerLazySingleton<AuthRepository>(
//     () => AuthRepositoryImpl(getIt<AuthService>(), getIt<TokenService>()),
//   );

//   // getIt.registerLazySingleton<TodoService>(
//   //   () => TodoService(getIt<HiveService>()),
//   // );
//   getIt.registerLazySingleton<TodoRemoteDataSource>(
//     () => TodoRemoteDataSourceImp(getIt<ApiService>()),
//   );

//   getIt.registerLazySingleton<TodoRepository>(
//     () => TodoRepositoryImpl(getIt<TodoRemoteDataSource>(),getIt<TodoLocalDataSource>()),
//   );

//   getIt.registerFactory<AuthViewModel>(
//     () => AuthViewModel(getIt<AuthRepository>()),
//   );

//   getIt.registerFactory<SplashViewModel>(
//     () => SplashViewModel(getIt<TokenService>()),
//   );

//   getIt.registerFactory<GetTodoUseCase>(
//     () => GetTodoUseCase(getIt<TodoRepository>()),
//   );

//   getIt.registerFactory<CreateTodoUseCase>(
//     () => CreateTodoUseCase(getIt<TodoRepository>()),
//   );

//   getIt.registerFactory<UpdateTodoUseCase>(
//     () => UpdateTodoUseCase(getIt<TodoRepository>()),
//   );

//   getIt.registerFactory<DeleteTodoUseCase>(
//     () => DeleteTodoUseCase(getIt<TodoRepository>()),
//   );

//   getIt.registerLazySingleton<TodoCubit>(
//     () => TodoCubit(
//       getIt<GetTodoUseCase>(),
//       getIt<CreateTodoUseCase>(),
//       getIt<UpdateTodoUseCase>(),
//       getIt<DeleteTodoUseCase>(),
//     ),
//   );

//   getIt.registerFactory<OnboardingViewModel>(() => OnboardingViewModel());
// }
