import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_it/app/screens/calendar/calendar_controller.dart';
import 'package:todo_it/app/screens/calendar/widgets/week_row.dart';
import 'calendar_day_box.dart';
import 'calendar_header.dart';

Widget monthCalendar(int changeCalendarMonth) {
  CalendarController calendarController = Get.find<CalendarController>();
  List<Widget> days = [];
  List<Widget> days2 = [];
  List<Widget> days3 = [];
  List<Widget> days4 = [];
  List<Widget> days5 = [];
  DateTime now = DateTime.now();
  DateTime firstDayOfCurrentMonth = DateTime(now.year, calendarController.currentDate.month, 1);
  DateTime lastDayOfPreviousMonth =
      firstDayOfCurrentMonth.subtract(const Duration(days: 1));
  int daysInPreMonth = lastDayOfPreviousMonth.day;
  int currentDay = 0;

  for (int i = calendarController.getWeekDay(); i > 1; i--) {
    days.add(
      Column(
        children: [
          Text(
            "${daysInPreMonth - i + 2}",
            style: const TextStyle(fontSize: 25, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  for (int i = calendarController.getWeekDay(); i <= 7; i++) {
    days.add(
      CalendarDayBox(
        currentDay: i - calendarController.getWeekDay() + 1,
      ),
    );
    if (i == 7) {
      currentDay = i - calendarController.getWeekDay() + 1;
    }
  }

  for (int i = 1; i <= 7; i++) {
    currentDay++;
    days2.add(
      CalendarDayBox(currentDay: currentDay),
    );
  }
  for (int i = 0; i < 7; i++) {
    currentDay++;
    days3.add(
      CalendarDayBox(currentDay: currentDay),
    );
  }
  for (int i = 0; i < 7; i++) {
    currentDay++;
    days4.add(
      CalendarDayBox(currentDay: currentDay),
    );
  }
  for (int i = 0; i < 7; i++) {
    currentDay++;
    if (currentDay > daysInPreMonth) {
      break;
    }
    days5.add(
      CalendarDayBox(currentDay: currentDay),
    );
  }

  return Column(
    children: [
      const Padding(
        padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CalendarHeader(char: "M"),
              CalendarHeader(char: "T"),
              CalendarHeader(char: "W"),
              CalendarHeader(char: "T"),
              CalendarHeader(char: "F"),
              CalendarHeader(char: "S"),
              CalendarHeader(char: "S"),
            ],
          ),
        ),
      ),
      const SizedBox(height: 5),
      const Divider(),
      const SizedBox(height: 5),
      WeekRow(days: days),
      WeekRow(days: days2),
      WeekRow(days: days3),
      WeekRow(days: days4),
      WeekRow(days: days5),
    ],
  );
}


