import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_do_app/core/constants/app_colors.dart';

class CustomMainButton extends StatelessWidget {
  final String text;
  final bool loading;
  final VoidCallback ontap;
  const CustomMainButton({
    super.key,
    required this.text,
    this.loading = false,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(8.r),
      ),

      child: TextButton(
        onPressed: ontap,
        child: loading
            ? CircularProgressIndicator(color: Colors.white)
            : Text(text, style: Theme.of(context).textTheme.displaySmall),
      ),
    );
  }
}
