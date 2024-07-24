import 'dart:convert';
import 'package:uuid/uuid.dart';
import '../enums/priority_enum.dart';

class Task {
  String id;
  String? title;
  String? description;
  DateTime? startDate;
  bool? isCompleted;
  Priority? priority;

  Task({
    String? id,
    this.title,
    this.description,
    this.startDate,
    this.priority,
    this.isCompleted = false,
  }) : id = id ?? const Uuid().v4();

  factory Task.fromJson(Map<String, dynamic> jsonData) {
    return Task(
      id: jsonData['id'].toString(),
      title: jsonData['title'],
      description: jsonData['desc'],
      startDate: DateTime.parse(jsonData['startDate']),
      priority: Priority.values
          .firstWhere((e) => e.toString() == jsonData['priority']),
      isCompleted: jsonData['isCompleted'],
    );
  }

  static Map<String, dynamic> toMap(Task task) => {
    'id': task.id,
    'title': task.title,
    'desc': task.description,
    'startDate': task.startDate?.toIso8601String(),
    'priority': task.priority?.toString(),
    'isCompleted': task.isCompleted,
  };

  static String encode(List<Task> tasks) => json.encode(
    tasks.map<Map<String, dynamic>>((task) => Task.toMap(task)).toList(),
  );

  static List<Task> decode(String tasks) =>
      (json.decode(tasks) as List<dynamic>)
          .map<Task>((item) => Task.fromJson(item))
          .toList();

  copyWith(Task sourceTask) {
    return Task(
      id: sourceTask.id,
      title: sourceTask.title,
      description: sourceTask.description,
      startDate: sourceTask.startDate,
      priority: sourceTask.priority,
      isCompleted: sourceTask.isCompleted
    );
  }

}

