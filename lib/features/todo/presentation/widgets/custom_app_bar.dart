import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget>? actions;
  final String? title;
  const CustomAppBar({super.key, this.actions, this.title});

  @override
  Widget build(BuildContext context) {
    return  AppBar(
    backgroundColor: Colors.transparent,
    centerTitle: true,
    title: Text(
    title??"",
    style: TextStyle(
    color: Colors.white,
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
    ),
    ),
    actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
