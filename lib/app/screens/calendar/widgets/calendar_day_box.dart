import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/local/models/task_model.dart';
import '../calendar_controller.dart';
import 'calendar_day.dart';
import 'show_tasks_by_selected_date.dart';

class CalendarDayBox extends StatefulWidget {
  const CalendarDayBox({
    super.key,
    required this.currentDay,
    required this.now,
  });

  final int currentDay;
  final DateTime now;

  @override
  State<CalendarDayBox> createState() => _CalendarDayBoxState();
}

class _CalendarDayBoxState extends State<CalendarDayBox> {
  List<Task> currentTasks = [];
  CalendarController calendarController = Get.find<CalendarController>();

  @override
  void initState() {
    super.initState();
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    currentTasks = await calendarController.taskRepository.getByDate(
        0, DateTime(widget.now.year, widget.now.month, widget.currentDay));
    setState(() {}); // Refresh the state to reflect the fetched tasks
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (currentTasks.isNotEmpty) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return ShowTasksSelectedDate(currentTasks: currentTasks);
            },
          );
        }
      },
      highlightColor: Colors.blue,
      splashColor: Colors.lightBlueAccent,
      borderRadius: const BorderRadius.all(
        Radius.circular(5),
      ),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        constraints: BoxConstraints.loose(
          const Size.fromHeight(60),
        ),
        child: SingleChildScrollView(
            child: CalendarDay(
          currentDay: widget.currentDay,
        )),
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

