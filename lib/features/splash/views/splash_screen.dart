import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/features/splash/splash_viewmodel/splash_viewmodel.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    )..forward();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SplashViewmodel>().checkAuth();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<SplashViewmodel>(
        builder: (context, vm, _) {
          if (vm.state == SplashState.authenticated) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.go('/home');
            });
          }

          if (vm.state == SplashState.unauthenticated) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.go('/onboarding');
            });
          }

          return Center(
            child: AnimatedContainer(
              duration: const Duration(seconds: 3),
              child: Container(
                height: 180.h,
                width: 140.w,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/icon.png'),
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
