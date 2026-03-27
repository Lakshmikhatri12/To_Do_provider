// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';

// class TaskModel {
//   final String id;
//   final String title;
//   final String? description;
//   final DateTime? dateTime;
//   final bool? completed;
//   final Priority priority;
//   final String? categoryLabel;
//   final Color? categoryColor;
//   final IconData? categoryIcon;

//   TaskModel({
//     required this.id,
//     required this.title,
//     this.description,
//     this.dateTime,
//     this.completed=false,
//     required this.priority,
//     this.categoryLabel,
//     this.categoryColor,
//     this.categoryIcon,
//   });
// }

import 'package:flutter/material.dart';

class TaskModel {
  int? userId;
  int? id;
  String? title;
  String? description;
  DateTime? dateTime;
  bool? completed;
  String? categoryLabel;
  Color? categoryColor;
  IconData? categoryIcon;
  TaskModel({
    this.userId,
    this.id,
    this.title,
    this.completed,
    this.description,
    this.categoryLabel,
    this.categoryColor,
    this.categoryIcon,
    this.dateTime,
  });

  TaskModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    completed = json['completed'];
    description = json['description'];
    dateTime = json['dateTime'] != null
        ? DateTime.parse(json['dateTime'])
        : null;

    categoryLabel = json['categoryLabel'];
    categoryColor = json['categoryColor'];
    categoryIcon = json['categoryIcon'];
  }

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "id": id,
      "title": title,
      "completed": completed,
      "dateTime": dateTime?.toIso8601String(),
      "description": description,
      "categoryLabel": categoryLabel,
      "categoryColor": categoryColor,
      "categoryIcon": categoryIcon,
    };
  }
}
