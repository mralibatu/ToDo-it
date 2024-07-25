import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_it/app/screens/main/main_controller.dart';
import 'package:todo_it/app/screens/main/widgets/repeat.dart';

import '../../../data/local/models/task_model.dart';
import 'card_date.dart';

class CardExpand extends StatelessWidget {
  const CardExpand({required this.task, super.key});

  final Task task;

  @override
  Widget build(BuildContext context) {
    MainController mainController = Get.find<MainController>();
    return Align(
      child: mainController.isDatepickerShow
          ? const Text("")
          : Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CardRepeat(task: task),
          CardDate(task: task),
        ],
      ),
    );;
  }
}