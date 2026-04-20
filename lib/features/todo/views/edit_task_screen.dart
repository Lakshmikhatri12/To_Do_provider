import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/core/constants/app_colors.dart';
import 'package:to_do_app/core/utils/snackbar_utils.dart';
import 'package:to_do_app/features/auth/widgets/custom_button.dart';
import 'package:to_do_app/features/todo/entities/task_entity.dart';
import 'package:to_do_app/features/todo/services/date_picker_service.dart';
import 'package:to_do_app/features/todo/view_models/task_view_model.dart';

import '../widgets/custom_edit_textfield.dart';

class EditTaskScreen extends StatefulWidget {
  final TaskEntity task;
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
    FocusScope.of(context).unfocus();
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
            CustomEditTextField(controller: _titleController, hint: 'Task title'),
            20.verticalSpace,
            _buildLabel('Description'),
            8.verticalSpace,
            CustomEditTextField(
              controller: _descController,
              hint: 'Description (optional)',
              maxLines: 3,
            ),
            20.verticalSpace,
            _buildLabel('Date & Time'),
            8.verticalSpace,
            CustomEditTextField(
              onTap: () => pickDate(),
              readOnly: true,
              icon: Icons.calendar_month_outlined,
              hint: _selectedDateTime != null
                  ? DateFormat('d/M/yyyy - h:mm a').format(_selectedDateTime!)
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


}
