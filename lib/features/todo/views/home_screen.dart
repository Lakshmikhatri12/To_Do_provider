import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/core/constants/app_colors.dart';
import 'package:to_do_app/core/router/app_routes.dart';
import 'package:to_do_app/features/auth/view_models/auth_view_model.dart';
import 'package:to_do_app/features/todo/view_models/task_view_model.dart';
import 'package:to_do_app/features/todo/widgets/add_task_button.dart';
import 'package:to_do_app/features/todo/views/add_task_sheet.dart';
import 'package:to_do_app/features/todo/widgets/empty_widget.dart';
import 'package:to_do_app/features/todo/widgets/task_card.dart';

import '../widgets/custom_app_bar.dart';

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
      context.read<TaskViewModel>().getTodos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _appBar(context),
      body: Consumer<TaskViewModel>(
        builder: (context, vm, _) {
          // Initial load — no tasks yet, show full-screen spinner
          if (vm.state == TaskState.loading && vm.tasks.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF8875FF)),
            );
          }

          if (vm.state == TaskState.error && vm.tasks.isEmpty) {
            return Center(
              child: Text(
                vm.errorMessage ?? 'Something went wrong',
                style: const TextStyle(color: Colors.white70),
              ),
            );
          }

          if (vm.tasks.isEmpty) {
            return const Center(child: EmptyWidget());
          }

          // Stack: list + overlay loading HUD when creating/updating
          return Stack(
            children: [
              _tasksList(vm),
              if (vm.state == TaskState.loading)
                Container(
                  color: Colors.black.withOpacity(0.3),
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFF8875FF),
                    ),
                  ),
                ),
            ],
          );
        },
      ),

      floatingActionButton: _addTaskButton(context),
    );
  }

  Padding _tasksList(TaskViewModel vm) {
    return Padding(
          padding: EdgeInsets.all(16.h),
          child: Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  color: Colors.white,
                  onRefresh: () => vm.getTodos(),
                  child: ListView.builder(
                    itemCount: vm.tasks.length,
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.only(bottom: 100.h, top: 4.h),
                    itemBuilder: (context, index) {
                      return TaskCard(task: vm.tasks[index],
                      onTapEdit: ()async{
                        await context.pushNamed<bool>(AppRoutes.edit, extra: vm.tasks[index]);
                      },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
  }



  /// Widgets
  AddTaskButton _addTaskButton(BuildContext context) {
    return AddTaskButton(onPressed: (){
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) => ChangeNotifierProvider.value(
          value: context.read<TaskViewModel>(),
          child: const AddTaskSheet(),
        ),
      );
    });
  }

  CustomAppBar _appBar(BuildContext context) {
    return CustomAppBar(
      title: "My Tasks",
      actions: [
        IconButton(
          icon: Icon(Icons.logout_rounded, color: Colors.white, size: 22.r),
          onPressed: () async {
            context.read<AuthViewModel>().logOut();
            if (context.mounted) {
              context.goNamed(AppRoutes.login);
            }
          },
        ),
      ],
    );
  }
}
