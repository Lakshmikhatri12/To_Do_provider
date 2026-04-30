import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/core/constants/app_colors.dart';
import 'package:to_do_app/features/todo/domain/entities/task_entity.dart';
import 'package:to_do_app/features/todo/presentation/cubit/todo_cubit.dart';
import 'package:to_do_app/features/todo/presentation/widgets/category_helper.dart';

class TaskCard extends StatelessWidget {
  final TaskEntity task;
  final VoidCallback onTapEdit;

  const TaskCard({super.key, required this.task, required this.onTapEdit});

  String _formatDate(DateTime dt) {
    return DateFormat('d/M/yyyy - h:mm a').format(dt);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Dismissible(
        key: ValueKey(task.id),
        direction: DismissDirection.endToStart,
        background: Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 20.w),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Icon(Icons.delete, color: Colors.white, size: 28.r),
        ),
        confirmDismiss: (_) async {
          context.read<TodoCubit>().deleteTodo(task);
          return false;
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.cardColor,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            children: [
              Checkbox(
                shape: CircleBorder(),
                checkColor: AppColors.primary,
                value: task.completed,
                onChanged: (val) {
                  context.read<TodoCubit>().toggleComplete(task);
                },
              ),
              10.horizontalSpace,

              // Task details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      task.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        decoration: task.completed
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    4.verticalSpace,
                    if (task.description.isNotEmpty)
                      Text(
                        task.description,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12.sp,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    if (task.dateTime != null)
                      Text(
                        _formatDate(task.dateTime!),
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12.sp,
                        ),
                      ),
                  ],
                ),
              ),

              //    Edit button
              Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  children: [
                    if (task.category != null)
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: CategoryHelper.getColor(
                            task.category,
                          ).withOpacity(0.5),
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              CategoryHelper.getIcon(task.category),
                              color: Colors.white,
                              size: 16.r,
                            ),
                            6.horizontalSpace,
                            Text(
                              task.category.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    8.horizontalSpace,
                    if (task.priority > 0)
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.flag_outlined,
                              color: Colors.white,
                              size: 16.r,
                            ),
                            6.horizontalSpace,
                            Text(
                              task.priority.toString(),
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
                      onTap: onTapEdit,
                      child: Icon(Icons.edit, color: Colors.white, size: 18.r),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
