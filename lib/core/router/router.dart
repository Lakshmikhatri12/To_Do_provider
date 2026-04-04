import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:to_do_app/core/di/service_locator.dart';
import 'package:to_do_app/features/auth/views/login_screen.dart';
import 'package:to_do_app/features/auth/views/signup_screen.dart';
import 'package:to_do_app/features/onboarding/views/get_start_screen.dart';
import 'package:to_do_app/features/onboarding/views/onboarding_screens.dart';
import 'package:to_do_app/features/splash/views/splash_screen.dart';
import 'package:to_do_app/features/todo/models/task_model.dart';
import 'package:to_do_app/features/todo/views/edit_task_screen.dart';
import 'package:to_do_app/features/todo/views/home_screen.dart';

final router = GoRouter(
  initialLocation: '/splash',

  redirect: (context, state) async {
    final storage = getIt<FlutterSecureStorage>();
    final token = await storage.read(key: 'access_token');
    final isLoggedIn = token != null && token.isNotEmpty;
    final onAuth = state.matchedLocation.startsWith('/auth');
    final onSplash = state.matchedLocation == '/splash';
    final onOnboarding = state.matchedLocation == '/onboarding';
    final onStart = state.matchedLocation == '/start';

    if (onSplash || onOnboarding || onStart) return null;
    if (!isLoggedIn && !onAuth) return '/auth/login';
    if (isLoggedIn && onAuth) return '/home';
    return null;
  },

  routes: [
    GoRoute(path: '/splash', builder: (_, __) => const SplashScreen()),
    GoRoute(path: '/onboarding', builder: (_, __) => const OnboardingScreen()),
    GoRoute(path: '/auth/login', builder: (_, __) => const LoginScreen()),
    GoRoute(path: '/auth/signup', builder: (_, __) => const SignUpScreen()),
    GoRoute(path: '/home', builder: (_, __) => const HomeScreen()),
    GoRoute(
      path: '/edit',
      builder: (_, state) {
        final task = state.extra as TaskModel;
        return EditTaskScreen(task: task);
      },
    ),
    GoRoute(path: '/start', builder: (_, __) => const GetStartScreen()),
  ],
);
