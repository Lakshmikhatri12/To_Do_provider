import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_do_app/core/constants/app_colors.dart';

class CustomTextfield extends StatelessWidget {
  final String hint;
  final String? title;
  final bool obscureText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final VoidCallback? onSuffixTap;
  final FocusNode? focusNode;
  final Color? fillColor;
  final bool filled;

  const CustomTextfield({
    super.key,
    required this.hint,
    this.title,
    required this.obscureText,
    this.controller,
    this.validator,
    this.keyboardType,
    this.suffixIcon,
    this.focusNode,
    this.fillColor,
    this.filled = false,
    this.onSuffixTap,
  });

  factory CustomTextfield.auth({
    required String hint,
    required String title,
    required bool obscureText,
    TextEditingController? controller,
    String? Function(String?)? validator,
    Widget? suffixIcon,
    VoidCallback? onSuffixTap,
    FocusNode? focusNode,
    TextInputType? keyboardType,
  }) {
    return CustomTextfield(
      hint: hint,
      title: title,
      obscureText: obscureText,
      controller: controller,
      validator: validator,
      suffixIcon: suffixIcon != null
          ? GestureDetector(onTap: onSuffixTap, child: suffixIcon)
          : null,
      focusNode: focusNode,
      keyboardType: keyboardType,
      fillColor: const Color(0xF3A3A3C),
      filled: true,
    );
  }

  factory CustomTextfield.task({
    required String hint,
    required bool obscureText,
    TextEditingController? controller,
    String? Function(String?)? validator,
    FocusNode? focusNode,
  }) {
    return CustomTextfield(
      hint: hint,
      obscureText: obscureText,
      controller: controller,
      validator: validator,
      focusNode: focusNode,
      fillColor: const Color(0xF3A3A3C),
      filled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          obscureText: obscureText,
          controller: controller,
          validator: validator,
          keyboardType: keyboardType,
          focusNode: focusNode,
          style: TextStyle(
            color: filled ? Colors.white : null,
            fontSize: 14.sp,
          ),
          decoration: InputDecoration(
            hintText: hint,
            filled: filled,
            fillColor: fillColor,
            suffixIcon: suffixIcon,
            hintStyle: Theme.of(context).textTheme.displaySmall?.copyWith(
              color: filled ? Colors.white38 : Colors.grey,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(
                color: filled ? Colors.white12 : Colors.white,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(
                color: filled ? Colors.white12 : Colors.white,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: const BorderSide(
                color: AppColors.primary,
                width: 1.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: Colors.red.shade400),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: Colors.red.shade600, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}
