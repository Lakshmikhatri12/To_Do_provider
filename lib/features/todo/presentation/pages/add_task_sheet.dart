import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/core/constants/app_colors.dart';
import 'package:to_do_app/features/auth/widgets/custom_textfield.dart';
import 'package:to_do_app/features/todo/presentation/cubit/todo_cubit.dart';
import 'package:to_do_app/core/utils/date_picker_service.dart';
import '../widgets/category_dialog.dart';
import '../widgets/priority_dialog.dart';

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
  int? _selectedPriority;
  DateTime? _selectedDateTime;

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    _titleFocus.dispose();
    super.dispose();
  }

  // ─── Actions ────────────────────────────────────────

  void _onSend() {
    final text = _titleController.text.trim();
    if (text.isEmpty) return;

    context.read<TodoCubit>().createTodo(
          text,
          description: _descController.text.trim(),
          category: _selectedLabel,
          priority: _selectedPriority,
          dateTime: _selectedDateTime,
        );
    Navigator.pop(context);
  }

  void _pickDateTime() async {
    final dateTime = await DatePickerService.pickDateTime(context);
    if (dateTime != null && mounted) {
      setState(() => _selectedDateTime = dateTime);
    }
  }

  void _showCategoryDialog() async {
    final result = await showDialog(
      context: context,
      builder: (_) => const CategoryDialog(),
    );
    if (result != null && mounted) {
      setState(() {
        _selectedIcon = result['icon'];
        _selectedLabel = result['label'];
        _selectedColor = result['color'];
      });
    }
  }

  void _showPriorityDialog() async {
    final priority = await showDialog<int>(
      context: context,
      builder: (_) => const PriorityDialog(),
    );
    if (priority != null && mounted) {
      setState(() => _selectedPriority = priority);
    }
  }

  // ─── Build ──────────────────────────────────────────

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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDragHandle(),
            16.verticalSpace,
            _buildTitle(),
            16.verticalSpace,
            _buildTitleField(),
            12.verticalSpace,
            _buildDescField(),
            16.verticalSpace,
            _buildBottomBar(),
            20.verticalSpace,
          ],
        ),
      ),
    );
  }

  // ─── Widgets ────────────────────────────────────────

  Widget _buildDragHandle() {
    return Center(
      child: Container(
        width: 40.w,
        height: 4.h,
        decoration: BoxDecoration(
          color: Colors.white24,
          borderRadius: BorderRadius.circular(2.r),
        ),
      ),
    );
  }

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

  Widget _buildTitleField() {
    return CustomTextfield.task(
      hint: 'Do Grocery',
      obscureText: false,
      controller: _titleController,
    );
  }

  Widget _buildDescField() {
    return CustomTextfield.task(
      controller: _descController,
      hint: 'Description (Optional)',
      obscureText: false,
    );
  }

  Widget _buildBottomBar() {
    return Row(
      children: [
        _buildDateButton(),
        16.horizontalSpace,
        _buildCategoryButton(),
        16.horizontalSpace,
        _buildPriorityButton(),
        const Spacer(),
        _buildSendButton(),
      ],
    );
  }

  Widget _buildDateButton() {
    return GestureDetector(
      onTap: _pickDateTime,
      child: Icon(Icons.timer_outlined, color: Colors.white, size: 18.r),
    );
  }

  Widget _buildCategoryButton() {
    return GestureDetector(
      onTap: _showCategoryDialog,
      child: _selectedLabel == null
          ? Icon(
              Icons.label_important_outline,
              color: Colors.white,
              size: 18.sp,
            )
          : _buildChip(
              label: _selectedLabel!,
              icon: _selectedIcon!,
              color: _selectedColor!,
            ),
    );
  }

  Widget _buildPriorityButton() {
    return GestureDetector(
      onTap: _showPriorityDialog,
      child: _selectedPriority == null
          ? Icon(Icons.flag_outlined, color: Colors.white, size: 18.sp)
          : _buildChip(
              label: 'P$_selectedPriority',
              icon: Icons.flag_outlined,
              color: const Color(0xFF8875FF),
            ),
    );
  }

  Widget _buildChip({
    required String label,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: color, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 16.sp),
          4.horizontalSpace,
          Text(
            label,
            style: TextStyle(color: color, fontSize: 12.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildSendButton() {
    return IconButton(
      onPressed: _onSend,
      icon: Icon(Icons.send_rounded, color: AppColors.primary, size: 26.sp),
    );
  }
}
