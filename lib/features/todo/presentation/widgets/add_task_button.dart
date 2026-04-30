import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddTaskButton extends StatelessWidget {
  final VoidCallback onPressed;
  const AddTaskButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h, right: 10.w),
      child: FloatingActionButton(
        onPressed: onPressed,
        backgroundColor: const Color(0xFF8875FF),
        child: Icon(Icons.add, size: 26.r, color: Colors.white),
      ),
    );
  }
}
