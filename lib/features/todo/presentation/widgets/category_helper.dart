import 'package:flutter/material.dart';

class CategoryHelper {
  static const Map<String, IconData> iconMap = {
    'Grocery': Icons.local_grocery_store_outlined,
    'Education': Icons.school_outlined,
    'Design': Icons.design_services_outlined,
    'Social': Icons.campaign,
    'Music': Icons.music_note_outlined,
    'Videos': Icons.video_library_outlined,
    'Health': Icons.monitor_heart_outlined,
    'Fitness': Icons.fitness_center,
    'Home': Icons.home_outlined,
    'Work': Icons.work_outline,
    'Other': Icons.category_outlined,
  };

  static const Map<String, Color> colorMap = {
    'Grocery': Color(0xFF8875FF),
    'Education': Color(0xFF4D9FFF),
    'Design': Color(0xFF4CAF82),
    'Social': Color(0xFFB6E040),
    'Music': Color(0xFFFFD23F),
    'Videos': Color(0xFFFF8C42),
    'Health': Color(0xFFFF4D6D),
    'Fitness': Color(0xFFFF6EC7),
    'Home': Color(0xFF4FA4CF),
    'Work': Color(0xFF3DFABC),
    'Other': Color(0xFF00D4D4),
  };

  static IconData getIcon(String? category) {
    return iconMap[category] ?? Icons.task_alt;
  }

  static Color getColor(String? category) {
    return colorMap[category] ?? const Color(0xFF8875FF);
  }

  static const List<int> priorityValues = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  static int getPriority(int? priority) {
    if (priority == null) return 1;
    return priorityValues.contains(priority) ? priority : 1;
  }
}
