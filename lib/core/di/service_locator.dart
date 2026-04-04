import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:to_do_app/core/network/api_service.dart';
import 'package:to_do_app/features/auth/repositories/auth_repository.dart';
import 'package:to_do_app/features/auth/repositories/auth_repository_impl.dart';
import 'package:to_do_app/features/auth/services/auth_service.dart';
import 'package:to_do_app/features/auth/viewmodels/auth_viewmodel.dart';
import 'package:to_do_app/features/onboarding/view_model/onboarding_viewmodel.dart';
import 'package:to_do_app/features/splash/splash_viewmodel/splash_viewmodel.dart';
import 'package:to_do_app/features/todo/repositories/todo_repository.dart';
import 'package:to_do_app/features/todo/repositories/todo_repository_impl.dart';
import 'package:to_do_app/features/todo/services/todo_service.dart';
import 'package:to_do_app/features/todo/viewmodels/task_viewmodel.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<Dio>(() => Dio());

  getIt.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );

  getIt.registerLazySingleton<ApiService>(
    () => ApiService(getIt<Dio>(), getIt<FlutterSecureStorage>()),
  );

  getIt.registerLazySingleton<AuthService>(
    () => AuthService(getIt<ApiService>()),
  );

  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt<AuthService>()),
  );

  getIt.registerLazySingleton<TodoService>(
    () => TodoService(getIt<ApiService>()),
  );

  getIt.registerLazySingleton<TodoRepository>(
    () => TodoRepositoryImpl(getIt<TodoService>()),
  );

  getIt.registerFactory<AuthViewmodel>(
    () => AuthViewmodel(getIt<AuthRepository>(), getIt<FlutterSecureStorage>()),
  );

  getIt.registerFactory<SplashViewmodel>(
    () => SplashViewmodel(getIt<FlutterSecureStorage>()),
  );

  getIt.registerFactory<TaskViewmodel>(
    () => TaskViewmodel(getIt<TodoRepository>()),
  );

  getIt.registerFactory<OnboardingViewModel>(() => OnboardingViewModel());
}
