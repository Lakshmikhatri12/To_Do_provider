import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:to_do_app/core/network/api_service.dart';
import 'package:to_do_app/features/auth/repositories/auth_repository.dart';
import 'package:to_do_app/features/auth/repositories/auth_repository_impl.dart';
import 'package:to_do_app/features/auth/services/auth_service.dart';
import 'package:to_do_app/features/auth/services/token_service.dart';
import 'package:to_do_app/features/auth/view_models/auth_view_model.dart';
import 'package:to_do_app/features/onboarding/view_models/onboarding_view_model.dart';
import 'package:to_do_app/features/splash/view_models/splash_view_model.dart';
import 'package:to_do_app/features/todo/repositories/todo_repository.dart';
import 'package:to_do_app/features/todo/repositories/todo_repository_impl.dart';
import 'package:to_do_app/features/todo/services/todo_service.dart';
import 'package:to_do_app/features/todo/viewmodels/task_view_model.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<Dio>(() => Dio());

  getIt.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );

  getIt.registerLazySingleton<TokenService>(
    () => TokenService(getIt<FlutterSecureStorage>()),
  );
  getIt.registerLazySingleton<ApiService>(
    () => ApiService(getIt<Dio>(), getIt<FlutterSecureStorage>()),
  );

  getIt.registerLazySingleton<AuthService>(
    () => AuthService(getIt<ApiService>()),
  );

  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt<AuthService>(), getIt<TokenService>()),
  );

  getIt.registerLazySingleton<TodoService>(
    () => TodoService(getIt<ApiService>()),
  );

  getIt.registerLazySingleton<TodoRepository>(
    () => TodoRepositoryImpl(getIt<TodoService>()),
  );

  getIt.registerFactory<AuthViewModel>(
    () => AuthViewModel(getIt<AuthRepository>()),
  );

  getIt.registerFactory<SplashViewModel>(
    () => SplashViewModel(getIt<TokenService>()),
  );

  getIt.registerFactory<TaskViewModel>(
    () => TaskViewModel(getIt<TodoRepository>()),
  );

  getIt.registerFactory<OnboardingViewModel>(() => OnboardingViewModel());
}
