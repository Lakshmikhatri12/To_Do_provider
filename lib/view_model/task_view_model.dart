import 'package:flutter/material.dart';
import 'package:to_do_app/core/constants/app_colors.dart';
import 'package:to_do_app/model/taskModel.dart';
import 'package:to_do_app/repositories/todo_repository.dart';

class TaskViewModel extends ChangeNotifier {
  final myrepo = ToDoRepository();
  IconData? categoryIcon;
  String? categoryLabel;
  Color? categoryColo;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  DateTime? selectedDateTime;
  List<TaskModel> tasks = [];
  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> fetchTodos() async {
    setLoading(true);
    try {
      tasks = await myrepo.getTodos();
    } catch (e) {
      e.toString();
    } finally {
      setLoading(false);
    }
  }

  Future<void> createTask() async {
    if (titleController.text.trim().isEmpty) return;
    setLoading(true);
    try {
      final newTask = await myrepo.createTodo(titleController.text.trim());
      newTask.description = descController.text.trim();
      newTask.dateTime = selectedDateTime;
      newTask.categoryColor = categoryColo;
      newTask.categoryIcon = categoryIcon;
      newTask.categoryLabel = categoryLabel;
      tasks.add(newTask);
      titleController.clear();
      descController.clear();
      selectedDateTime = null;
      categoryIcon = null;
      categoryLabel = null;
      categoryColo = null;
      ////show newtask on top
      tasks.insert(0, newTask);

      notifyListeners();
      print("task Created");
    } catch (e) {
      e.toString();
    } finally {
      setLoading(false);
    }
  }

  Future<void> updateTask(TaskModel task) async {
    setLoading(true);
    try {
      final updatedTask = await myrepo.updateTodo(task);
      final index = tasks.indexWhere((t) => t.id == task.id);
      if (index != -1) tasks[index] = updatedTask;
      notifyListeners();
      print("Task updated");
    } catch (e) {
      e.toString();
    } finally {
      setLoading(false);
    }
  }

  Future<void> deleteTask(int id) async {
    final backup = List<TaskModel>.from(tasks);
    tasks.removeWhere((task) => task.id == id);
    notifyListeners();

    try {
      await myrepo.deleteTodo(id);
    } catch (e) {
      tasks = backup;
      notifyListeners();
    }
  }

  //////////Date picker
  Future<void> pickDate(BuildContext context) async {
    final DateTime? date = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      initialDate: DateTime.now(),
      builder: (context, child) => _pickerTheme(context, child),
    );
    if (date == null) return;
    // Auto open time picker after date
    if (!context.mounted) return;
    await pickTime(context, date);
  }

  ///////////// time picker
  Future<void> pickTime(BuildContext context, DateTime date) async {
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) => _pickerTheme(context, child),
    );
    if (time == null) return;

    // Use time.hour and time.minute, not date.hour/date.month
    selectedDateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    notifyListeners();
  }

  void clearDateTime() {
    selectedDateTime = null;
    notifyListeners();
  }

  static Widget _pickerTheme(BuildContext context, Widget? child) {
    return Theme(
      data: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.dark(
          primary: AppColors.primary,
          onPrimary: Colors.white,
          surface: const Color(0xFF2C2C2E),
          onSurface: Colors.white,
        ),
        dialogBackgroundColor: const Color(0xFF2C2C2E),
      ),
      child: child!,
    );
  }
}
