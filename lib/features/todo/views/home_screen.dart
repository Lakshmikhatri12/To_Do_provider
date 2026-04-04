import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/core/constants/app_colors.dart';
import 'package:to_do_app/features/auth/viewmodels/auth_viewmodel.dart';
import '../viewmodels/task_viewmodel.dart';
import '../widgets/add_task_sheet.dart';
import '../widgets/empty_widget.dart';
import '../widgets/task_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TaskViewmodel>().getTodos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'My Tasks',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout_rounded, color: Colors.white, size: 22.r),
            onPressed: () async {
              context.read<AuthViewmodel>().logOut();
              if (context.mounted) {
                context.go('/auth/login');
              }
            },
          ),
        ],
      ),
      body: Consumer<TaskViewmodel>(
        builder: (context, vm, _) {
          if (vm.state == TaskState.loading) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF8875FF)),
            );
          }
          if (vm.tasks.isEmpty) {
            return const Center(child: EmptyWidget());
          }
          return Padding(
            padding: EdgeInsets.all(16.h),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: vm.tasks.length,
                    padding: EdgeInsets.only(bottom: 100.h, top: 4.h),
                    itemBuilder: (context, index) {
                      return TaskCard(task: vm.tasks[index]);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),

      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 20.h, right: 10.w),
        child: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (_) => const AddTaskSheet(),
            );
          },
          backgroundColor: const Color(0xFF8875FF),
          child: Icon(Icons.add, size: 26.r, color: Colors.white),
        ),
      ),
    );
  }
}
