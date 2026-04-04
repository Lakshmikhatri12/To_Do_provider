import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_do_app/core/constants/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final bool loading;
  final VoidCallback? ontap;
  const CustomButton({
    super.key,
    required this.text,
    this.loading = false,
    this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: 60.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(8.r),
        ),

        child: loading
            ? Center(child: CircularProgressIndicator(color: Colors.white))
            : Center(
                child: Text(
                  text,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ),
      ),
    );
  }
}
