import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_it/app/screens/calendar/calendar_controller.dart';
import 'package:todo_it/app/screens/calendar/widgets/month_calendar.dart';

import '../../commons/common.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    CalendarController calendarController = Get.find<CalendarController>();
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Calendar",
              style: TextStyle(
                color: calendarController.isDarkMode
                    ? Colors.white
                    : Colors.grey[800],
              ),
            ),
            Row(
              children: [
                IconButton(
                  color: calendarController.isDarkMode
                      ? Colors.white
                      : Colors.grey[800],
                  onPressed: () => calendarController.monthDecrease(),
                  icon: const Icon(Icons.arrow_back_ios_new),
                ),
                GetBuilder<CalendarController>(
                    init: CalendarController(),
                    builder: (calendarController) {
                      return Text(
                        getMonthName(calendarController.changeCalendarMonth),
                        style: TextStyle(
                          color: calendarController.isDarkMode
                              ? Colors.white
                              : Colors.grey[800],
                        ),
                      );
                    }),
                IconButton(
                  color: calendarController.isDarkMode
                      ? Colors.white
                      : Colors.grey[800],
                  onPressed: () => calendarController.monthIncrease(),
                  icon: const Icon(
                    Icons.arrow_forward_ios,
                  ),
                ),
              ],
            ),
          ],
        ),
        backgroundColor:
            !calendarController.isDarkMode ? Colors.white : Colors.grey[800],
      ),
      body: Center(
        child: GetBuilder<CalendarController>(
          init: CalendarController(),
          builder: (calendarController) {
            return monthCalendar(calendarController.changeCalendarMonth);
          },
        ),
      ),
    );
  }
}
