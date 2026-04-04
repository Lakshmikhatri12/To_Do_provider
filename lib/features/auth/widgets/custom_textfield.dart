import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextfield extends StatelessWidget {
  final String hint;
  final String title;
  final bool obsecureText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  const CustomTextfield({
    super.key,
    required this.hint,
    required this.title,
    this.controller,
    this.validator,
    required this.obsecureText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.displaySmall),
        8.verticalSpace,
        TextFormField(
          obscureText: obsecureText,
          controller: controller,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: Theme.of(
              context,
            ).textTheme.displaySmall?.copyWith(color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
