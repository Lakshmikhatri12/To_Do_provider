import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:to_do_app/core/constants/app_colors.dart';
import 'package:to_do_app/core/constants/app_sizes.dart';
import 'package:to_do_app/view/get_start_screen.dart';
import 'package:to_do_app/view_model/onboarding_view_model.dart';

class OnboardingScreens extends StatelessWidget {
  const OnboardingScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(AppSizes.paddingXL),
        child: Consumer<OnboardingViewModel>(
          builder: (context, value, child) {
            return Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => GetStartScreen()),
                      );
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
                      controller: value.controller,
                      onPageChanged: value.onPageChanged,
                      itemCount: value.pages.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Image.asset(
                              value.pages[value.currentpage]['image'],
                              height: 278.h,
                              width: 213.w,
                              fit: BoxFit.contain,
                            ),
                            SmoothPageIndicator(
                              effect: ExpandingDotsEffect(
                                dotWidth: 10.w,
                                dotHeight: 4,
                                dotColor: Colors.grey,
                                activeDotColor: AppColors.textColor,
                              ),
                              controller: value.controller,
                              count: value.pages.length,
                            ),
                            42.verticalSpace,
                            Text(
                              value.pages[value.currentpage]['title'],
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                            42.verticalSpace,
                            Text(
                              textAlign: TextAlign.center,
                              value.pages[value.currentpage]["subtitle"],
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: value.currentpage > 0
                          ? value.previousPage
                          : null,
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
                        onPressed: value.currentpage < value.pages.length - 1
                            ? value.nextPage
                            : () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => GetStartScreen(),
                                  ),
                                );
                              },
                        child: Text(
                          value.currentpage < value.pages.length - 1
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
