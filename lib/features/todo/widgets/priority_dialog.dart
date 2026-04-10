import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_do_app/core/constants/app_colors.dart';
import 'package:to_do_app/core/utils/snackbar_utils.dart';
import 'package:to_do_app/features/auth/widgets/custom_button.dart';

class PriorityDialog extends StatefulWidget {
  const PriorityDialog({super.key});

  @override
  State<PriorityDialog> createState() => _PriorityDialogState();
}

class _PriorityDialogState extends State<PriorityDialog> {
  int? _selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        height: 480.h,
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
          color: const Color(0xFF2C2C2E),
          borderRadius: BorderRadius.circular(5.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Task Priority',
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            10.verticalSpace,
            Divider(),
            10.verticalSpace,

            Flexible(
              child: GridView.builder(
                itemCount: 10,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10.w,
                  mainAxisSpacing: 10.h,
                  mainAxisExtent: 65.h,
                ),
                itemBuilder: (context, index) {
                  final isSelected = _selectedIndex == index;

                  return GestureDetector(
                    onTap: () => setState(() => _selectedIndex = index),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 60.r,
                          height: 60.r,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.background,

                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.flag_outlined,
                                color: Colors.white,
                                size: 22.r,
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                (index + 1).toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 30.h),

            CustomButton(
              text: "Select Priority",
              ontap: () {
                Navigator.pop(context, _selectedIndex! + 1);
              },
            ),
          ],
        ),
      ),
    );
  }
}
