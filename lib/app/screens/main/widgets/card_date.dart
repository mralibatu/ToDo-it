import 'package:flutter/material.dart';

import '../../../commons/common.dart';
import '../../../data/local/models/task_model.dart';

class CardDate extends StatelessWidget {
  const CardDate({required this.task, super.key});

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Text(
      getDayMonth(task),
      style: const TextStyle(fontSize: 15),
    );
  }
}