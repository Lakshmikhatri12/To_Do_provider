import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:to_do_app/core/constants/app_colors.dart';
import 'package:to_do_app/core/router/app_routes.dart';
import 'package:to_do_app/features/auth/view_models/auth_view_model.dart';
import 'package:to_do_app/features/todo/domain/entities/task_entity.dart';
import 'package:to_do_app/features/todo/presentation/cubit/todo_cubit.dart';
import 'package:to_do_app/features/todo/presentation/cubit/todo_state.dart';
import 'package:to_do_app/features/todo/presentation/widgets/add_task_button.dart';
import 'package:to_do_app/features/todo/presentation/pages/add_task_sheet.dart';
import 'package:to_do_app/features/todo/presentation/widgets/empty_widget.dart';
import 'package:to_do_app/features/todo/presentation/widgets/task_card.dart';

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
      context.read<TodoCubit>().getTodos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _appBar(context),
      body: BlocBuilder<TodoCubit, TodoState>(
        builder: (context, state) {
          if (state is InitTodoState || state is LoadingTodoState) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }
          if (state is ErrorTodoState) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.white70),
              ),
            );
          }
          if (state is ResponseTodoState) {
            if (state.todo.isEmpty) {
              return Center(child: EmptyWidget());
            }

            return _tasksList(state.todo);
          }
          return const Center(child: EmptyWidget());
        },
      ),
      floatingActionButton: _addTaskButton(context),
    );
  }

  Padding _tasksList(List<TaskEntity> todo) {
    return Padding(
      padding: EdgeInsets.all(16.h),
      child: Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              color: Colors.white,
              onRefresh: () => context.read<TodoCubit>().getTodos(),
              child: ListView.builder(
                itemCount: todo.length,
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.only(bottom: 100.h, top: 4.h),
                itemBuilder: (context, index) {
                  return TaskCard(
                    task: todo[index],
                    onTapEdit: () async {
                      await context.pushNamed<bool>(
                        AppRoutes.edit,
                        extra: todo[index],
                      );
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
    return AddTaskButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (_) => BlocProvider.value(
            value: context.read<TodoCubit>(),
            child: const AddTaskSheet(),
          ),
        );
      },
    );
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
