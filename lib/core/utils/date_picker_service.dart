import 'package:flutter/material.dart';
import 'package:to_do_app/core/constants/app_colors.dart';

class DatePickerService {
  static Future<DateTime?> pickDateTime(BuildContext context) async {
    final DateTime? date = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      initialDate: DateTime.now(),
      builder: (context, child) => _pickerTheme(context, child),
    );

    if (date == null) return null;
    if (!context.mounted) return null;

    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) => _pickerTheme(context, child),
    );

    if (time == null) return null;

    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  static Widget _pickerTheme(BuildContext context, Widget? child) {
    return Theme(
      data: ThemeData.dark().copyWith(
        textSelectionTheme: TextSelectionThemeData(
          selectionColor: AppColors.primary,
        ),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF8875FF),
          onPrimary: Colors.white,
          surface: Color(0xFF2C2C2E),
          onSurface: Colors.white,
        ),
        dialogBackgroundColor: const Color(0xFF2C2C2E),
      ),
      child: child!,
    );
  }
}
