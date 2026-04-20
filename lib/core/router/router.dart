import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/core/di/service_locator.dart';
import 'package:to_do_app/core/router/app_routes.dart';
import 'package:to_do_app/features/auth/services/token_service.dart';
import 'package:to_do_app/features/auth/views/login_screen.dart';
import 'package:to_do_app/features/auth/views/signup_screen.dart';
import 'package:to_do_app/features/onboarding/view_models/onboarding_view_model.dart';
import 'package:to_do_app/features/onboarding/views/get_start_screen.dart';
import 'package:to_do_app/features/onboarding/views/onboarding_screens.dart';
import 'package:to_do_app/features/splash/view_models/splash_view_model.dart';
import 'package:to_do_app/features/splash/views/splash_screen.dart';
import 'package:to_do_app/features/todo/entities/task_entity.dart';
import 'package:to_do_app/features/todo/view_models/task_view_model.dart';
import 'package:to_do_app/features/todo/views/edit_task_screen.dart';
import 'package:to_do_app/features/todo/views/home_screen.dart';

final router = GoRouter(
  initialLocation: AppRoutes.splashPath,

  redirect: (context, state) async {
    final tokenService = getIt<TokenService>();
    final token = await tokenService.getToken();
    final isLoggedIn = token != null && token.isNotEmpty;
    final onAuth =
        state.matchedLocation == AppRoutes.loginPath ||
        state.matchedLocation == AppRoutes.signupPath;
    final onSplash = state.matchedLocation == AppRoutes.splashPath;
    final onOnboarding = state.matchedLocation == AppRoutes.onboardingPath;
    final onStart = state.matchedLocation == AppRoutes.startPath;

    if (onSplash || onOnboarding || onStart) return null;
    if (!isLoggedIn && !onAuth) return AppRoutes.loginPath;
    if (isLoggedIn && onAuth) return AppRoutes.homePath;
    return null;
  },

  routes: [
    GoRoute(
      path: AppRoutes.splashPath,
      name: AppRoutes.splash,
      builder: (context, state) => ChangeNotifierProvider(
        create: (_) => getIt<SplashViewModel>(),
        builder: (context, child) => const SplashScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.onboardingPath,
      name: AppRoutes.onboarding,
      builder: (context, state) => ChangeNotifierProvider(
        create: (_) => getIt<OnboardingViewModel>(),
        builder: (context, child) => const OnboardingScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.startPath,
      name: AppRoutes.start,
      builder: (_, __) => const GetStartScreen(),
    ),
    GoRoute(
      path: AppRoutes.loginPath,
      name: AppRoutes.login,
      builder: (_, __) => const LoginScreen(),
    ),
    GoRoute(
      path: AppRoutes.signupPath,
      name: AppRoutes.signup,
      builder: (_, __) => const SignUpScreen(),
    ),
    GoRoute(
      path: AppRoutes.homePath,
      name: AppRoutes.home,
      builder: (context, state) => ChangeNotifierProvider(
        create: (_) => getIt<TaskViewModel>(),
        builder: (context, child) => const HomeScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.editPath,
      name: AppRoutes.edit,
      builder: (context, state) {
        final task = state.extra as TaskEntity;
        return ChangeNotifierProvider.value(
          value: getIt<TaskViewModel>(),
          child: EditTaskScreen(task: task),
        );
      },
    ),
  ],
);
