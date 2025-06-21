// lib/services/local_storage_service.dart
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskmaster/models/task.dart';

class LocalStorageService {
  static const String _tasksKey = 'tasks';

  Future<List<Task>> getTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final String? tasksString = prefs.getString(_tasksKey);

    if (tasksString != null) {
      final List<dynamic> taskMaps = json.decode(tasksString);
      return taskMaps.map((map) => Task.fromJson(map)).toList();
    }
    return [];
  }

  Future<void> saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final String tasksString = json.encode(
      tasks.map((task) => task.toJson()).toList(),
    );
    await prefs.setString(_tasksKey, tasksString);
  }
}
