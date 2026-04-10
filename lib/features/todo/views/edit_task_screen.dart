import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/core/constants/app_colors.dart';
import 'package:to_do_app/core/utils/snackbar_utils.dart';
import 'package:to_do_app/features/auth/widgets/custom_button.dart';
import 'package:to_do_app/features/todo/models/task_model/task_model.dart';
import 'package:to_do_app/features/todo/services/date_picker_service.dart';
import 'package:to_do_app/features/todo/viewmodels/task_view_model.dart';

class EditTaskScreen extends StatefulWidget {
  final TaskModel task;
  const EditTaskScreen({super.key, required this.task});

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descController;
  DateTime? _selectedDateTime;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task.title);
    _descController = TextEditingController(text: widget.task.description);
    _selectedDateTime = widget.task.dateTime;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _onUpdate() async {
    if (_titleController.text.trim().isEmpty) {
      SnackBarUtils.showError(context, 'Please enter task title');
      return;
    }

    final updatedTask = widget.task.copyWith(
      title: _titleController.text.trim(),
      description: _descController.text.trim(),
      dateTime: _selectedDateTime,
    );

    await context.read<TaskViewModel>().updateTodo(updatedTask);

    if (!mounted) return;
    Navigator.pop(context);
  }

  void pickDate() async {
    final dateTime = await DatePickerService.pickDateTime(context);
    if (dateTime != null) {
      setState(() {
        _selectedDateTime = dateTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(
          'Edit Task',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLabel('Title'),
            8.verticalSpace,
            _buildTextField(controller: _titleController, hint: 'Task title'),
            20.verticalSpace,

            _buildLabel('Description'),
            8.verticalSpace,

            _buildTextField(
              controller: _descController,
              hint: 'Description (optional)',
              maxLines: 3,
            ),
            20.verticalSpace,

            _buildLabel('Date & Time'),
            8.verticalSpace,

            _buildTextField(
              ontap: () => pickDate(),
              readOnly: true,
              icon: Icons.calendar_month_outlined,
              hint: _selectedDateTime != null
                  ? '${_selectedDateTime!.day}/${_selectedDateTime!.month}/${_selectedDateTime!.year}'
                        ' - ${_selectedDateTime!.hour}:${_selectedDateTime!.minute.toString().padLeft(2, '0')}'
                  : 'Select Date & Time',
            ),
            40.verticalSpace,

            Consumer<TaskViewModel>(
              builder: (context, vm, _) {
                return CustomButton(
                  text: "Update Task",
                  loading: vm.state == TaskState.loading,
                  ontap: _onUpdate,
                );
              },
            ),
            30.verticalSpace,
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white70,
        fontSize: 13.sp,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildTextField({
    bool readOnly = false,
    VoidCallback? ontap,
    TextEditingController? controller,
    required String hint,
    int maxLines = 1,
    IconData? icon,
  }) {
    return TextField(
      onTap: ontap,
      readOnly: readOnly,
      controller: controller,
      maxLines: maxLines,
      style: TextStyle(color: Colors.white, fontSize: 14.sp),
      decoration: InputDecoration(
        prefixIcon: icon != null
            ? Icon(icon, color: Colors.white, size: 18.r)
            : null,
        hintText: hint,
        hintStyle: TextStyle(color: Colors.white38, fontSize: 14.sp),
        contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(color: Colors.white12, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),
    );
  }
}
