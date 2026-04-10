import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:to_do_app/core/constants/app_colors.dart';
import 'package:to_do_app/core/router/app_routes.dart';
import 'package:to_do_app/features/onboarding/view_models/onboarding_viewModel.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(24.h),
        child: Consumer<OnboardingViewModel>(
          builder: (context, vm, child) {
            return Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: TextButton(
                    onPressed: () {
                      context.goNamed(AppRoutes.start);
                    },
                    child: Text(
                      "SKIP",
                      style: Theme.of(
                        context,
                      ).textTheme.displaySmall?.copyWith(color: Colors.grey),
                    ),
                  ),
                ),

                Center(
                  child: SizedBox(
                    height: 511.h,
                    width: 299.w,
                    child: PageView.builder(
                      controller: vm.controller,
                      onPageChanged: vm.onPageChanged,
                      itemCount: vm.pages.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Image.asset(
                              vm.pages[vm.currentPage].image,
                              height: 278.h,
                              width: 213.w,
                              fit: BoxFit.contain,
                            ),
                            SmoothPageIndicator(
                              effect: ExpandingDotsEffect(
                                dotWidth: 10.w,
                                dotHeight: 4,
                                dotColor: Colors.grey,
                                activeDotColor: AppColors.primary,
                              ),
                              controller: vm.controller,
                              count: vm.pages.length,
                            ),
                            42.verticalSpace,
                            Text(
                              vm.pages[vm.currentPage].title,
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                            42.verticalSpace,
                            Text(
                              textAlign: TextAlign.center,
                              vm.pages[vm.currentPage].subtitle,
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),

                const Spacer(),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: vm.currentPage > 0 ? vm.previousPage : null,
                      child: Text(
                        "BACK",
                        style: Theme.of(
                          context,
                        ).textTheme.displaySmall?.copyWith(color: Colors.grey),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: TextButton(
                        onPressed: vm.currentPage < vm.pages.length - 1
                            ? vm.nextPage
                            : () {
                                context.goNamed(AppRoutes.start);
                              },
                        child: Text(
                          vm.currentPage < vm.pages.length - 1
                              ? "NEXT"
                              : "Get Started",
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ),
                    ),
                  ],
                ),
                42.verticalSpace,
              ],
            );
          },
        ),
      ),
    );
  }
}
