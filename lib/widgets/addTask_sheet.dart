import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/core/constants/app_colors.dart';
import 'package:to_do_app/view_model/task_view_model.dart';
import 'package:to_do_app/widgets/category_dialog.dart';
import 'package:to_do_app/widgets/priority_dialog.dart';

// ── Entry point ──────────────────────────────────────────────────────────────

void showAddTaskSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true, // rises above keyboard
    backgroundColor: Colors.transparent,
    builder: (_) => const AddTaskSheet(),
  );
}

// ── Sheet Widget ─────────────────────────────────────────────────────────────

class AddTaskSheet extends StatefulWidget {
  const AddTaskSheet({super.key});

  @override
  State<AddTaskSheet> createState() => _AddTaskSheetState();
}

class _AddTaskSheetState extends State<AddTaskSheet> {
  IconData? _selectedIcon;
  String? _selectedLabel;
  Color? _selectedColor;
  final FocusNode _titleFocus = FocusNode();

  @override
  void dispose() {
    _titleFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      // Shift sheet up when keyboard appears
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF2C2C2E),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 20.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitle(),
            SizedBox(height: 16.h),
            _buildTitleField(),
            SizedBox(height: 12.h),
            _buildDescriptionField(),
            SizedBox(height: 16.h),
            _buildActionRow(),
          ],
        ),
      ),
    );
  }

  // ── "Add Task" heading

  Widget _buildTitle() {
    return Text(
      'Add Task',
      style: TextStyle(
        color: Colors.white,
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.2,
      ),
    );
  }

  // ── Title text field

  Widget _buildTitleField() {
    final vm = Provider.of<TaskViewModel>(context);
    return TextField(
      controller: vm.titleController,
      focusNode: _titleFocus,
      style: TextStyle(color: Colors.white, fontSize: 14.sp),
      decoration: InputDecoration(
        hintText: 'Do math homework',
        hintStyle: TextStyle(color: Colors.white38, fontSize: 14.sp),
        filled: true,
        fillColor: const Color(0xFF3A3A3C),
        contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
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
    );
  }

  // ── Description field

  Widget _buildDescriptionField() {
    final vm = Provider.of<TaskViewModel>(context);
    return TextField(
      controller: vm.descController,
      style: TextStyle(color: Colors.white70, fontSize: 13.sp),
      maxLines: 2,
      decoration: InputDecoration(
        hintText: 'Description',
        hintStyle: TextStyle(color: Colors.white38, fontSize: 13.sp),
        isDense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
      ),
    );
  }

  // ── Bottom row

  Widget _buildActionRow() {
    final vm = Provider.of<TaskViewModel>(context);
    return Row(
      children: [
        _ActionIcon(
          icon: Icons.timer_outlined,
          onTap: () => context.read<TaskViewModel>().pickDate(context),
        ),
        SizedBox(width: 16.w),
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
              vm.categoryIcon = result['icon'];
              vm.categoryLabel = result['label'];
              vm.categoryColo = result['color'];
            }
          },
          child: _selectedLabel == null
              ? Icon(
                  Icons.label_important_outline,
                  color: Colors.white,
                  size: 26.sp,
                )
              : Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: _selectedColor!.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: _selectedColor!, width: 1),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(_selectedIcon, color: _selectedColor, size: 16.sp),
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
        SizedBox(width: 16.w),
        _ActionIcon(
          icon: Icons.flag_outlined,
          onTap: () {
            showDialog(context: context, builder: (_) => PriorityDialog());
          },
        ),
        const Spacer(),
        _SendButton(
          onTap: () async {
            context.read<TaskViewModel>();
            await vm.createTask();
            if (!mounted) return;
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}

// ── Reusable action icon

class _ActionIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _ActionIcon({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(icon, color: Colors.white, size: 26.sp),
    );
  }
}

// ── Send button ──────────────────

class _SendButton extends StatelessWidget {
  final VoidCallback onTap;

  const _SendButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36.w,
        height: 36.w,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Icon(Icons.send_rounded, color: AppColors.primary, size: 26.sp),
      ),
    );
  }
}
