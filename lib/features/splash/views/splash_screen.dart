import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/core/router/app_routes.dart';
import 'package:to_do_app/features/splash/view_models/splash_view_model.dart';
import 'package:to_do_app/gen/assets.gen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late SplashViewModel vm;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    )..forward();

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   vm.addListener(onSplashStateChanged);
    //   vm.checkAuth();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      vm = context.read<SplashViewModel>();
      vm.addListener(onSplashStateChanged);
      vm.checkAuth();
    });
  }

  void onSplashStateChanged() {
    if (!mounted) return;
    if (vm.state == SplashState.authenticated) {
      context.goNamed(AppRoutes.home);
    } else if (vm.state == SplashState.unauthenticated) {
      context.goNamed(AppRoutes.onboarding);
    }
  }

  @override
  void dispose() {
    vm.removeListener(onSplashStateChanged);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<SplashViewModel>(
        builder: (context, vm, _) {
          return Center(
            child: AnimatedContainer(
              duration: Duration(seconds: 3),
              child: Container(
                height: 180.h,
                width: 140.w,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(Assets.icons.icon.path),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
