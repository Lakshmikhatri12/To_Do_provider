import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/core/constants/app_colors.dart';
import 'package:to_do_app/core/utils.dart';
import 'package:to_do_app/model/taskModel.dart';
import 'package:to_do_app/view_model/task_view_model.dart';
import 'package:to_do_app/widgets/custom_main_button.dart';

class EditTask extends StatefulWidget {
  final TaskModel task;
  const EditTask({super.key, required this.task});

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  late TextEditingController titleController;
  late TextEditingController descController;

  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.task.title);
    descController = TextEditingController(text: widget.task.description);

    final vm = Provider.of<TaskViewModel>(context, listen: false);
    vm.selectedDateTime = widget.task.dateTime;
  }

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<TaskViewModel>(context);
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          spacing: 20.h,
          children: [
            TextField(
              controller: titleController,
              style: TextStyle(color: Colors.white, fontSize: 14.sp),
              decoration: InputDecoration(
                hintText: widget.task.title,
                hintStyle: TextStyle(color: Colors.white, fontSize: 14.sp),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 14.w,
                  vertical: 12.h,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(color: Colors.white12, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(color: AppColors.primary, width: 1.5),
                ),
              ),
            ),
            TextField(
              controller: descController,
              style: TextStyle(color: Colors.white, fontSize: 14.sp),
              decoration: InputDecoration(
                hintText: widget.task.description,
                hintStyle: TextStyle(color: Colors.white, fontSize: 14.sp),

                contentPadding: EdgeInsets.symmetric(
                  horizontal: 14.w,
                  vertical: 12.h,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(color: Colors.white12, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(color: AppColors.primary, width: 1.5),
                ),
              ),
            ),
            // TextField(
            //   readOnly: true,
            //   style: TextStyle(color: Colors.white, fontSize: 14.sp),
            //   decoration: InputDecoration(
            //     suffixIcon: IconButton(
            //       onPressed: () {},
            //       icon: Icon(Icons.category_outlined, color: Colors.white),
            //     ),
            //     hintText: 'Category',
            //     hintStyle: TextStyle(color: Colors.white, fontSize: 14.sp),

            //     contentPadding: EdgeInsets.symmetric(
            //       horizontal: 14.w,
            //       vertical: 12.h,
            //     ),
            //     border: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(10.r),
            //       borderSide: BorderSide.none,
            //     ),
            //     enabledBorder: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(10.r),
            //       borderSide: BorderSide(color: Colors.white12, width: 1),
            //     ),
            //     focusedBorder: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(10.r),
            //       borderSide: BorderSide(color: AppColors.primary, width: 1.5),
            //     ),
            //   ),
            // ),
            TextField(
              readOnly: true,
              style: TextStyle(color: Colors.white, fontSize: 14.sp),
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () async {
                    vm.pickDate(context);
                  },
                  icon: Icon(
                    Icons.calendar_month_outlined,
                    color: Colors.white,
                  ),
                ),
                hintText: vm.selectedDateTime != null
                    ? "${vm.selectedDateTime!.day}/${vm.selectedDateTime!.month}/${vm.selectedDateTime!.year} - ${vm.selectedDateTime!.hour}:${vm.selectedDateTime!.minute.toString().padLeft(2, '0')}"
                    : "DateTime",
                hintStyle: TextStyle(color: Colors.white, fontSize: 14.sp),

                contentPadding: EdgeInsets.symmetric(
                  horizontal: 14.w,
                  vertical: 12.h,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(color: Colors.white12, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(color: AppColors.primary, width: 1.5),
                ),
              ),
            ),
            Spacer(),
            CustomMainButton(
              loading: vm.loading,
              text: "Update",
              ontap: () async {
                final updatedTask = widget.task;
                updatedTask.title = titleController.text.toString();
                updatedTask.description = descController.text.toString();
                updatedTask.dateTime = vm.selectedDateTime;

                await vm.updateTask(updatedTask);

                if (!mounted) return;
                Navigator.pop(context);
                print("Task updated");
                Utils.flushbarErrorMesaage("Udpated", Colors.green, context);
              },
            ),
            30.verticalSpace,
          ],
        ),
      ),
    );
  }
}
