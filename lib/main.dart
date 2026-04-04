import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/core/Theme/custom_theme/app_theme.dart';
import 'package:to_do_app/features/onboarding/view_model/onboarding_viewmodel.dart';
import 'package:to_do_app/features/splash/splash_viewmodel/splash_viewmodel.dart';
import 'core/di/service_locator.dart';
import 'core/router/router.dart';
import 'features/auth/viewmodels/auth_viewmodel.dart';
import 'features/todo/viewmodels/task_viewmodel.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(
    ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      ensureScreenSize: true,
      builder: (context, child) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthViewmodel>(
          create: (_) => getIt<AuthViewmodel>(),
        ),
        ChangeNotifierProvider<SplashViewmodel>(
          create: (_) => getIt<SplashViewmodel>(),
        ),
        ChangeNotifierProvider<TaskViewmodel>(
          create: (_) => getIt<TaskViewmodel>(),
        ),
        ChangeNotifierProvider<OnboardingViewModel>(
          create: (_) => getIt<OnboardingViewModel>(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router,
        theme: AppTheme.themeData,
      ),
    );
  }
}
