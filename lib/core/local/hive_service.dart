import 'package:flutter/foundation.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:to_do_app/features/todo/entities/task_entity.dart';

class HiveService {
  static const todoBox = 'todo';

  final Box<TaskEntity> box = Hive.box<TaskEntity>(todoBox);

  Future<void> saveTasks(List<TaskEntity> tasks) async {
    final map = {for (var task in tasks) task.id: task};
    await box.putAll(map);
  }

  List<TaskEntity> getAllTasks() {
    return box.values.toList();
  }

  Future<void> addTask({required TaskEntity task}) async {
    await box.add(task);
  }

  Future<TaskEntity?> updateTask({required TaskEntity task}) async {
    await box.put(task.id, task);
    return box.get(task.id);
  }

  Future<void> deleteTask({required int id}) async {
    await box.delete(id);
  }

  Future<void> clearAllTask() async {
    await box.clear();
  }

  ValueListenable<Box<TaskEntity>> listenToTasks() => box.listenable();
}
