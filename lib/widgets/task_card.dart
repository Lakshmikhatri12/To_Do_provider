import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_do_app/core/constants/app_colors.dart';
import 'package:to_do_app/model/taskModel.dart';

class TaskCard extends StatefulWidget {
  final TaskModel task;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  const TaskCard({super.key, required this.task, this.onEdit, this.onDelete});

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    final task = widget.task;

    return Dismissible(
      key: ValueKey(task.id ?? UniqueKey()),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20.w),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: Icon(Icons.delete, color: Colors.white, size: 28.r),
      ),
      onDismissed: (_) {
        if (widget.onDelete != null) widget.onDelete!();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFF2C2C2E),
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  task.completed = !(task.completed ?? false);
                });
              },
              child: Container(
                width: 22.w,
                height: 22.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white38, width: 2),
                  color: (task.completed ?? false)
                      ? AppColors.primary
                      : Colors.transparent,
                ),
              ),
            ),
            10.horizontalSpace,

            // Task details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    task.title ?? "No Title",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      decoration: (task.completed ?? false)
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    task.dateTime != null ? formatDate(task.dateTime!) : "",
                    style: TextStyle(color: Colors.white54, fontSize: 12.sp),
                  ),
                ],
              ),
            ),

            // Edit button
            Align(
              alignment: Alignment.bottomRight,
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                    decoration: BoxDecoration(
                      color: task.categoryColor,
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                    child: Row(
                      children: [
                        Icon(task.categoryIcon, color: Colors.white),
                        5.horizontalSpace,
                        Text(
                          task.categoryLabel ?? "",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  8.horizontalSpace,
                  GestureDetector(
                    onTap: widget.onEdit,
                    child: Icon(Icons.edit, color: Colors.white, size: 22.r),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Optional: 12-hour AM/PM format
  String formatDate(DateTime dt) {
    final hour = dt.hour > 12 ? dt.hour - 12 : (dt.hour == 0 ? 12 : dt.hour);
    final minute = dt.minute.toString().padLeft(2, '0');
    final period = dt.hour >= 12 ? "PM" : "AM";
    return "${dt.day}/${dt.month}/${dt.year} - $hour:$minute $period";
  }
}
