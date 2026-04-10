import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/core/constants/app_colors.dart';
import 'package:to_do_app/gen/assets.gen.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10.h,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          Assets.images.empty.path,
          height: 277,
          width: 277,
          fit: BoxFit.contain,
        ),
        Text(
          "What do you want to do today",
          style: GoogleFonts.lato(
            fontSize: 20.sp,
            color: AppColors.textColor,
            height: 1.505,
          ),
        ),
        Text(
          "Tap + to add your tasks",
          style: GoogleFonts.lato(
            fontSize: 16.sp,
            color: AppColors.textColor,
            height: 1.505,
          ),
        ),
      ],
    );
  }
}
