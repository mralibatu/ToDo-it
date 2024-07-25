import 'package:flutter/material.dart';
import 'package:todo_it/app/data/local/enums/priority_enum.dart';

import '../../../data/local/models/task_model.dart';

class CardIcon extends StatelessWidget {
  const CardIcon(
      {
        required this.task,
        super.key}
      );

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.crisis_alert,
      color: getIconColor(task.priority!),
    );
  }
}

Color? getIconColor(Priority priority)
{
  switch (priority) {
    case Priority.basic:
      return Colors.grey;
    case Priority.urgent:
      return Colors.orange[300];
    case Priority.important:
      return Colors.red[300];
    case Priority.urgentImportant:
      return Colors.red;
  }
}