import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60.h,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: Icon(Icons.menu_rounded),
        title: Text("Index"),
        actions: [
          CircleAvatar(
            radius: 25.r,
            backgroundColor: const Color.fromARGB(255, 51, 50, 50),
            child: Icon(
              Icons.person_2_rounded,
              color: const Color.fromARGB(255, 121, 122, 122),
              size: 38.r,
            ),
          ),
        ],
      ),
    );
  }
}
