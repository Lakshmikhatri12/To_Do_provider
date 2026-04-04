import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/core/constants/app_colors.dart';
import 'package:to_do_app/features/auth/viewmodels/auth_viewmodel.dart';
import 'package:to_do_app/features/todo/services/date_picker_service.dart';
import 'package:to_do_app/features/todo/viewmodels/task_viewmodel.dart';
import 'category_dialog.dart';
import 'priority_dialog.dart';

class AddTaskSheet extends StatefulWidget {
  const AddTaskSheet({super.key});

  @override
  State<AddTaskSheet> createState() => _AddTaskSheetState();
}

class _AddTaskSheetState extends State<AddTaskSheet> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _titleFocus = FocusNode();

  IconData? _selectedIcon;
  String? _selectedLabel;
  Color? _selectedColor;
  int _selectedPriority = 1;

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    _titleFocus.dispose();
    super.dispose();
  }

  void _onSend(TaskViewmodel vm) {
    final text = _titleController.text.trim();
    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please enter task title'),
          backgroundColor: Colors.red.shade700,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    vm.createTodo(
      text,
      description: _descController.text.trim(),
      category: _selectedLabel,
      priority: _selectedPriority,
      dateTime: vm.selectedDateTime,
    );
    Navigator.pop(context);
  }

  void pickDateTime() async {
    final dateTime = await DatePickerService.pickDateTime(context);
    if (dateTime != null && context.mounted) {
      context.read<TaskViewmodel>().setDateTime(dateTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF2C2C2E),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 20.h),
        child: Consumer<TaskViewmodel>(
          builder: (context, vm, _) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ),
                16.verticalSpace,

                Text(
                  'Add Task',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.2,
                  ),
                ),
                16.verticalSpace,

                TextField(
                  controller: _titleController,
                  focusNode: _titleFocus,
                  autofocus: true,
                  style: TextStyle(color: Colors.white, fontSize: 14.sp),
                  decoration: InputDecoration(
                    hintText: 'Do math homework',
                    hintStyle: TextStyle(
                      color: Colors.white38,
                      fontSize: 14.sp,
                    ),
                    filled: true,
                    fillColor: const Color(0xFF3A3A3C),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 12.h,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: const BorderSide(
                        color: Colors.white12,
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: const BorderSide(
                        color: Color(0xFF8875FF),
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
                12.verticalSpace,

                TextField(
                  controller: _descController,
                  style: TextStyle(color: Colors.white70, fontSize: 13.sp),
                  maxLines: 2,
                  decoration: InputDecoration(
                    hintText: 'Description (optional)',
                    hintStyle: TextStyle(
                      color: Colors.white38,
                      fontSize: 13.sp,
                    ),
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 4.w,
                      vertical: 4.h,
                    ),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                ),
                16.verticalSpace,

                Row(
                  children: [
                    GestureDetector(
                      onTap: () => pickDateTime(),
                      child: Icon(
                        Icons.timer_outlined,
                        color: Colors.white,
                        size: 20.r,
                      ),
                    ),
                    16.horizontalSpace,

                    GestureDetector(
                      onTap: () async {
                        final result = await showDialog(
                          context: context,
                          builder: (_) => const CategoryDialog(),
                        );
                        if (result != null) {
                          setState(() {
                            _selectedIcon = result['icon'];
                            _selectedLabel = result['label'];
                            _selectedColor = result['color'];
                          });
                        }
                      },
                      child: _selectedLabel == null
                          ? Icon(
                              Icons.label_important_outline,
                              color: Colors.white,
                              size: 26.sp,
                            )
                          : Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.w,
                                vertical: 4.h,
                              ),
                              decoration: BoxDecoration(
                                color: _selectedColor!.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(8.r),
                                border: Border.all(
                                  color: _selectedColor!,
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    _selectedIcon,
                                    color: _selectedColor,
                                    size: 16.sp,
                                  ),
                                  4.horizontalSpace,
                                  Text(
                                    _selectedLabel!,
                                    style: TextStyle(
                                      color: _selectedColor,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ),
                    16.horizontalSpace,
                    GestureDetector(
                      onTap: () async {
                        final priority = await showDialog<int>(
                          context: context,
                          builder: (_) => const PriorityDialog(),
                        );
                        if (priority != null) {
                          setState(() {
                            _selectedPriority = priority;
                          });
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF8875FF).withOpacity(0.15),
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(
                            color: const Color(0xFF8875FF),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.flag_outlined,
                              color: const Color(0xFF8875FF),
                              size: 16.sp,
                            ),
                            4.horizontalSpace,
                            Text(
                              'P$_selectedPriority',
                              style: TextStyle(
                                color: const Color(0xFF8875FF),
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const Spacer(),

                    // Send Button
                    GestureDetector(
                      onTap: () => _onSend(vm),
                      child: Icon(
                        Icons.send_rounded,
                        color: AppColors.primary,
                        size: 20.sp,
                      ),
                    ),
                  ],
                ),
                20.verticalSpace,
              ],
            );
          },
        ),
      ),
    );
  }
}
