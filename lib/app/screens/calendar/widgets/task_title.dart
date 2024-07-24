import 'package:flutter/material.dart';
import 'package:todo_it/app/data/local/models/task_model.dart';

class TaskTitle extends StatelessWidget {
  const TaskTitle({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.label_important),
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 5),
          child: Text(
            "${task.title}\n",
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
        ),
      ],
    );
  }
}