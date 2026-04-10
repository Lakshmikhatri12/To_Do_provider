import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_do_app/core/constants/app_colors.dart';

class SnackBarUtils {
  static void showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(10.r),
        ),
        backgroundColor: AppColors.errorColor,
        content: Text(message, style: TextStyle(color: Colors.white)),
      ),
    );
  }

  static void showSuccess(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(10.r),
        ),
        backgroundColor: Colors.green,
        content: Text(message, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
