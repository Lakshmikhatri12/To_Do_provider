import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_do_app/core/utils/snackbar_utils.dart';
import 'package:to_do_app/features/todo/widgets/category_helper.dart';

class CategoryDialog extends StatefulWidget {
  const CategoryDialog({super.key});

  @override
  State<CategoryDialog> createState() => _CategoryDialogState();
}

class _CategoryDialogState extends State<CategoryDialog> {
  int _selectedIndex = 0;
  final List<String> _labels = CategoryHelper.iconMap.keys.toList();
  void selectCategory() {
    final label = _labels[_selectedIndex];
    Navigator.pop(context, {
      'icon': CategoryHelper.getIcon(label),
      'label': label,
      'color': CategoryHelper.getColor(label),
    });
  }

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
                itemCount: _labels.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 20.w,
                  mainAxisSpacing: 20.h,
                  mainAxisExtent: 80.h,
                ),
                itemBuilder: (context, index) {
                  final label = _labels[index];
                  final icons = CategoryHelper.getIcon(label);
                  final colors = CategoryHelper.getColor(label);
                  final isSelected = _selectedIndex == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = index;
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
                            color: colors.withOpacity(isSelected ? 1.0 : 0.2),
                            borderRadius: BorderRadius.circular(5.r),
                            border: isSelected
                                ? Border.all(color: Colors.white, width: 2)
                                : null,
                          ),
                          child: Icon(
                            icons,
                            color: isSelected ? Colors.white : colors,
                            size: 22.r,
                          ),
                        ),
                        4.verticalSpace,
                        Text(
                          label,
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
                  if (_selectedIndex >= 0) {
                    selectCategory();
                  } else {
                    SnackBarUtils.showError(context, 'Please select category');
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
