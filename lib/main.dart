import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/core/local/hive_service.dart';
import 'package:to_do_app/core/theme/app_theme.dart';
import 'package:to_do_app/features/auth/view_models/auth_view_model.dart';
import 'package:to_do_app/features/todo/entities/task_entity.dart';
import 'core/di/service_locator.dart';
import 'core/router/app_router.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter<TaskEntity>(TaskEntityAdapter());

  await Hive.openBox<TaskEntity>(HiveService.todoBox);
  print("Hive box opened: ${Hive.isBoxOpen(HiveService.todoBox)}");
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

// class BaseWidget extends InheritedWidget {
//   BaseWidget({Key? key, required this.child}) : super(key: key, child: child);
//   final HiveService dataStore = HiveService();
//   final Widget child;

//   static BaseWidget of(BuildContext context) {
//     final base = context.dependOnInheritedWidgetOfExactType<BaseWidget>();
//     if (base != null) {
//       return base;
//     } else {
//       throw ('Could not find ancestor widget of type BaseWidget');
//     }
//   }

//   @override
//   bool updateShouldNotify(covariant InheritedWidget oldWidget) {
//     return false;
//   }
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthViewModel>(
      create: (_) => getIt<AuthViewModel>(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router,
        theme: AppTheme.themeData,
      ),
    );
  }
}
