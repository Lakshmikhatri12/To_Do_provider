import 'package:flutter/foundation.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:to_do_app/features/todo/domain/entities/task_entity.dart';

class HiveService {
  static const todoBox = 'todo';

  final Box<TaskEntity> box = Hive.box<TaskEntity>(todoBox);

  List<TaskEntity> getAllTasks() {
    return box.values.toList();
  }

  Future<void> addTask({required TaskEntity task}) async {
    await box.put(task.id, task);
  }

  Future<void> updateTask({required TaskEntity task}) async {
    await box.put(task.id, task);
  }

  Future<void> deleteTask({required int id}) async {
    await box.delete(id);
  }

  Future<void> clearAllTask() async {
    await box.clear();
  }

  ValueListenable<Box<TaskEntity>> listenToTasks() => box.listenable();
}
