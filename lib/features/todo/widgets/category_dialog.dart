import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    const Color(0xFF8875FF),
    const Color(0xFF4D9FFF),
    const Color(0xFF00D4D4),
    const Color(0xFF4CAF82),
    const Color(0xFFB6E040),
    const Color(0xFFFFD23F),
    const Color(0xFFFF8C42),
    const Color(0xFFFF4D6D),
    const Color(0xFFFF6EC7),
    const Color(0xFF4FA4CF),
    const Color(0xFF3DFABC),
  ];

  final List<IconData> icons = [
    Icons.local_grocery_store_outlined,
    Icons.school_outlined,
    Icons.design_services_outlined,
    Icons.campaign,
    Icons.music_note_outlined,
    Icons.video_library_outlined,
    Icons.monitor_heart_outlined,
    Icons.fitness_center,
    Icons.home_outlined,
    Icons.work_outline,
    Icons.category_outlined,
  ];

  final List<String> iconLabels = [
    'Grocery',
    'Education',
    'Design',
    'Social',
    'Music',
    'Videos',
    'Health',
    'Fitness',
    'Home',
    'Work',
    'Other',
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
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            10.verticalSpace,
            const Divider(color: Colors.white12),
            10.verticalSpace,

            Flexible(
              child: GridView.builder(
                itemCount: icons.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 20.w,
                  mainAxisSpacing: 20.h,
                  mainAxisExtent: 80.h,
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
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: 60.r,
                          height: 60.r,
                          decoration: BoxDecoration(
                            color: colors[index].withOpacity(
                              isSelected ? 1.0 : 0.2,
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
                        4.verticalSpace,
                        Text(
                          iconLabels[index],
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 11.sp,
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
            30.verticalSpace,

            SizedBox(
              width: double.infinity,
              height: 52.h,
              child: ElevatedButton(
                onPressed: () {
                  if (icon != null && label != null && color != null) {
                    Navigator.pop(context, {
                      'icon': icon,
                      'label': label,
                      'color': color,
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Please select a category'),
                        backgroundColor: Colors.red.shade700,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8875FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'Select Category',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            20.verticalSpace,
          ],
        ),
      ),
    );
  }
}
