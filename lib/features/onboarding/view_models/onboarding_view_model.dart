import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:to_do_app/features/onboarding/models/onboarding_page_model.dart';
import 'package:to_do_app/gen/assets.gen.dart';

@lazySingleton
class OnboardingViewModel extends ChangeNotifier {
  final PageController controller = PageController();

  final List<OnboardingPageModel> pages = [
    OnboardingPageModel(
      image: Assets.images.a1.path,
      title: "Manage your tasks",
      subtitle:
          "You can manage easily all of your daily tasks in DoMe for free.",
    ),
    OnboardingPageModel(
      image: Assets.images.a2.path,
      title: "Create daily routine",
      subtitle:
          "In UpToDo you can create your personalized routine to stay productive.",
    ),
    OnboardingPageModel(
      image: Assets.images.a3.path,
      title: "Organize your tasks",
      subtitle:
          "You can manage easily all of your daily tasks in DoMe for free.",
    ),
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
