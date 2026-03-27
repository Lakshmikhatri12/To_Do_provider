import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_do_app/widgets/custom_main_button.dart';

class CategoryDialog extends StatefulWidget {
  const CategoryDialog({super.key});

  @override
  State<CategoryDialog> createState() => _CategoryDialogState();
}

class _CategoryDialogState extends State<CategoryDialog> {
  int _selectedIndex = 0;
  IconData? icon;
  Color? color;
  String? label;

  final List<Color> colors = [
    Color(0xFF8875FF),
    Color(0xFF4D9FFF),
    Color(0xFF00D4D4),
    Color(0xFF4CAF82),
    Color(0xFFB6E040),
    Color(0xFFFFD23F),
    Color(0xFFFF8C42),
    Color(0xFFFF4D6D),
    Color(0xFFFF6EC7),
    Color(0xFF4FA4CF),
    Color(0xFF3DFABC),
  ];

  final List<IconData> icons = [
    Icons.local_grocery_store_outlined,
    Icons.school_outlined,
    Icons.category_outlined,
    Icons.design_services_outlined,
    Icons.campaign,
    Icons.music_note_outlined,
    Icons.video_library_outlined,
    Icons.monitor_heart_outlined,
    Icons.fitness_center,
    Icons.home_outlined,
    Icons.work_outline,
  ];

  final List<String> iconLabels = [
    'Grocery',
    'Education',
    'Category',
    'Design',
    'Social',
    'Music',
    'Videos',
    'Health',
    'Fitness',
    'Home',
    'Work',
  ];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        height: 550.h,
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
          color: const Color(0xFF2C2C2E),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Choose Category',
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
                itemCount: icons.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 20.w,
                  mainAxisSpacing: 20.h,
                  mainAxisExtent: 75.h,
                ),
                itemBuilder: (context, index) {
                  final isSelected = _selectedIndex == index;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = index;
                        icon = icons[index];
                        label = iconLabels[index];
                        color = colors[index];
                      });
                      //   => setState(() => _selectedIndex = index),
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 60.r,
                          height: 60.r,
                          decoration: BoxDecoration(
                            color: colors[index].withOpacity(
                              isSelected ? 1.0 : 0.25,
                            ),
                            borderRadius: BorderRadius.circular(5.r),
                            border: isSelected
                                ? Border.all(color: Colors.white, width: 2)
                                : null,
                          ),
                          child: Icon(
                            icons[index],
                            color: isSelected ? Colors.white : colors[index],
                            size: 22.r,
                          ),
                        ),
                        Text(
                          iconLabels[index],
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
                  );
                },
              ),
            ),
            SizedBox(height: 30.h),
            CustomMainButton(
              text: "Select Category",
              ontap: () {
                if (icon != null && label != null && color != null) {
                  Navigator.pop(context, {
                    'icon': icon,
                    'label': label,
                    'color': color,
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please select a category')),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
