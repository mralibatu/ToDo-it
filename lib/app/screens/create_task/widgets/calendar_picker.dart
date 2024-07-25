import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_it/app/screens/create_task/create_task_controller.dart';

class CalendarPicker extends StatefulWidget {
  const CalendarPicker({super.key});

  @override
  State<CalendarPicker> createState() => _CalendarPickerState();
}

class _CalendarPickerState extends State<CalendarPicker> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    CreateTaskController createTaskController = Get.find<CreateTaskController>();
    return TableCalendar(
      focusedDay: selectedDate, // Focused day burada kullanılıyor
      firstDay: DateTime.now(),
      lastDay: DateTime(DateTime.now().year + 1),
      selectedDayPredicate: (day) {
        return isSameDay(selectedDate, day); // Selected date burada kontrol ediliyor
      },
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          selectedDate = selectedDay;
        });
        createTaskController.selectDate(selectedDay);
      },
    );
  }
}
