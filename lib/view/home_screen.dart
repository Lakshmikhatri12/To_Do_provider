import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/view/edit_task.dart';
import 'package:to_do_app/view_model/task_view_model.dart';
import 'package:to_do_app/widgets/addTask_sheet.dart';
import 'package:to_do_app/widgets/empty_widget.dart';
import 'package:to_do_app/widgets/task_card.dart';

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
      context.read<TaskViewModel>().fetchTodos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60.h,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: Icon(Icons.menu_rounded),
        title: Text("Index"),
      ),
      body: Consumer<TaskViewModel>(
        builder: (context, value, child) {
          if (value.loading) {
            return Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          }
          if (value.tasks.isEmpty) {
            return Center(child: EmptyWidget());
          }
          return ListView.builder(
            itemCount: value.tasks.length,
            itemBuilder: (context, index) {
              final task = value.tasks[index];
              return Padding(
                padding: EdgeInsets.all(10.sp),
                child: TaskCard(
                  task: task,
                  onDelete: () {
                    setState(() {
                      value.deleteTask(task.id!);
                    });
                  },
                  onEdit: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => EditTask(task: task)),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20, right: 10),
        child: FloatingActionButton(
          onPressed: () {
            showAddTaskSheet(context);
          },
          child: Icon(Icons.add, size: 26.r),
        ),
      ),
    );
  }
}
