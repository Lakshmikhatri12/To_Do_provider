import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_do_app/core/constants/app_colors.dart';

class SocialButton extends StatelessWidget {
  final String image;
  final String title;
  final VoidCallback ontap;
  const SocialButton({
    super.key,
    required this.image,
    required this.title,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.h,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primary, width: 2.w),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image, height: 20.h, width: 20.h, fit: BoxFit.cover),
          10.horizontalSpace,
          Text(title, style: Theme.of(context).textTheme.displaySmall),
        ],
      ),
    );
  }
}
