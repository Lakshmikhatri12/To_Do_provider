import 'package:flutter/material.dart';

class OnboardingViewModel extends ChangeNotifier {
  final PageController controller = PageController();

  final List<Map<String, String>> pages = [
    {
      "image": "assets/1.png",
      "title": "Manage your tasks",
      "subtitle":
          "You can manage easily all of your daily tasks in DoMe for free",
    },
    {
      "image": "assets/2.png",
      "title": "Create daily routine",
      "subtitle":
          "In UpToDo you can create your personalized routine to stay productive.",
    },
    {
      "image": "assets/3.png",
      "title": "Organize your tasks",
      "subtitle":
          "You can manage easily all of your daily tasks in DoMe for free",
    },
  ];

  int currentPage = 0;

  void onPageChanged(int index) {
    currentPage = index;
    notifyListeners();
  }

  void nextPage() {
    if (currentPage < pages.length - 1) {
      controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void previousPage() {
    if (currentPage > 0) {
      controller.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
