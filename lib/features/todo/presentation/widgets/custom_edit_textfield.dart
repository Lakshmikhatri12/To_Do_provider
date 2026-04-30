import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_do_app/core/constants/app_colors.dart';

class CustomEditTextField extends StatelessWidget {
  final bool readOnly;
  final VoidCallback? onTap;
  final TextEditingController? controller;
  final String hint;
  final int maxLines;
  final IconData? icon;

  const CustomEditTextField({
    super.key,
    this.readOnly = false,
    this.onTap,
    this.controller,
    required this.hint,
    this.maxLines = 1,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: onTap,
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