import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:get/get.dart';
import 'package:todo_it/app/data/repository/task_repository.dart';
import 'package:todo_it/app/screens/main/main_controller.dart';
import 'package:todo_it/app/Constants/constants.dart';

import '../../../commons/common.dart';

class DatePickerWidget extends StatefulWidget {
  const DatePickerWidget({super.key});

  @override
  State<DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  
  TaskRepository taskRepository = TaskRepository(taskProvider: Constants.dbContext);
  MainController mainController = Get.find<MainController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DatePicker(
          initialSelectedDate: DateTime.now(),
          height: 120,
          DateTime.now(),
          selectionColor: const Color(0xff447170),
          daysCount: getDaysCount(),
          selectedTextColor: Colors.white,
          onDateChange: (date){
            mainController.setSelectedDate(date);
          },
        ),
      ],
    );
  }
}
