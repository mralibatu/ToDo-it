import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_it/app/data/local/models/task_model.dart';

import '../calendar_controller.dart';
import 'task_desc.dart';
import 'task_title.dart';

class ShowTasksSelectedDate extends StatelessWidget {
  const ShowTasksSelectedDate({required this.currentTasks, super.key});

  final List<Task> currentTasks;

  @override
  Widget build(BuildContext context) {
    CalendarController calendarController = Get.find<CalendarController>();
    return AlertDialog(
      backgroundColor: calendarController.isDarkMode
          ? Colors.grey[800]
          : Colors.white,
      title: Text(
        "Tasks",
        style: TextStyle(
          color: calendarController.isDarkMode
              ? Colors.white
              : Colors.black,
        ),
      ),
      content: Container(
        color: calendarController.isDarkMode
            ? Colors.grey[800]
            : Colors.white,
        height: containerHeight(),
        width: 300,
        child: ListView.builder(
          itemCount: currentTasks.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Column(
                children: [
                  TaskTitle(task: currentTasks[index]),
                  TaskDescription(
                      task: currentTasks[index],
                      calendarController: calendarController),
                  if (index < currentTasks.length - 1)
                    const Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: Divider(),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
  double containerHeight() {
    switch (currentTasks.length) {
      case 1:
        return 100;
      case 2:
        return 220;
      default:
        return 300;
    }
  }
}
