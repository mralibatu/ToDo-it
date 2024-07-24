
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../calendar_controller.dart';

class CalendarHeader extends StatelessWidget {
  const CalendarHeader({
    super.key,
    required this.char,
  });

  final String char;

  @override
  Widget build(BuildContext context) {
    CalendarController calendarController = Get.find<CalendarController>();
    return Text(
      char,
      style: TextStyle(
        fontSize: 15,
        color: colorOfChar(char, calendarController)
      ),
    );
  }
}

Color colorOfChar(String input, CalendarController calendarController)
{
  return input == "S"
      ? Colors.redAccent
      : calendarController.isDarkMode
      ? Colors.white
      : Colors.black87;
}