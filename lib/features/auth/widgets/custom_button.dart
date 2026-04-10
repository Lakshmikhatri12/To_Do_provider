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
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        overlayColor: const Color.fromARGB(255, 125, 105, 253),
        backgroundColor: AppColors.primary,
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(8.r),
        ),
      ),
      onPressed: ontap,
      child: loading
          ? Center(child: CircularProgressIndicator(color: Colors.white))
          : Center(
              child: Text(
                text,
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
    );
  }
}
