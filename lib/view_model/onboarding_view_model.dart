import 'package:flutter/material.dart';

class OnboardingViewModel extends ChangeNotifier {
  List pages = [
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
  final PageController controller = PageController();
  int _currentpage = 0;

  int get currentpage => _currentpage;

  void onPageChanged(int index) {
    _currentpage = index;
    notifyListeners();
  }

  void nextPage() {
    controller.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void previousPage() {
    controller.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
