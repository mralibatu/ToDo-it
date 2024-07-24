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
  DateTime focusedDate = DateTime.now(); // Focused day değişkenini ekliyoruz

  @override
  Widget build(BuildContext context) {
    CreateTaskController createTaskController = Get.find<CreateTaskController>();
    return TableCalendar(
      focusedDay: focusedDate, // Focused day burada kullanılıyor
      firstDay: DateTime.now(),
      lastDay: DateTime(DateTime.now().year + 1),
      selectedDayPredicate: (day) {
        return isSameDay(selectedDate, day); // Selected date burada kontrol ediliyor
      },
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          selectedDate = selectedDay;
          focusedDate = focusedDay; // Focused day de güncelleniyor
        });
        createTaskController.selectDate(selectedDay);
      },
    );
  }
}
