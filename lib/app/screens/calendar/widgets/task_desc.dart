import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:todo_it/app/data/local/models/task_model.dart';
import 'package:todo_it/app/screens/calendar/calendar_controller.dart';

class TaskDescription extends StatelessWidget {
  const TaskDescription({
    super.key,
    required this.task,
    required this.calendarController,
  });

  final Task task;
  final CalendarController calendarController;

  @override
  Widget build(BuildContext context) {
    return ReadMoreText(
      "${task.description}",
      trimMode: TrimMode.Line,
      trimLines: 2,
      colorClickableText: Colors.redAccent[300],
      trimCollapsedText: 'Show more',
      trimExpandedText: 'Show less',
      moreStyle: TextStyle(
        color: calendarController.isDarkMode ? Colors.white : Colors.black,
      ),
    );
  }
}