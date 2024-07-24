import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../calendar_controller.dart';

class CalendarDay extends StatelessWidget {
  const CalendarDay({required this.currentDay, super.key});

  final int currentDay;

  @override
  Widget build(BuildContext context) {
    CalendarController calendarController = Get.find<CalendarController>();
    bool isSingleDigit = currentDay < 10;
    return Column(
      children: [
        Text(
          isSingleDigit ? "0$currentDay" : "$currentDay",
          style: TextStyle(
            fontSize: 25,
            color: calendarController.isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        FutureBuilder<int>(
          future: calendarController.getTaskCount(currentDay),
          builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else if (!snapshot.hasData) {
              return const Text("No data available");
            } else {
              return Text(
                ".\n" * snapshot.data!,
                style: TextStyle(
                  fontSize: 20,
                  color: calendarController.isDarkMode
                      ? Colors.white
                      : Colors.black,
                  height: 0.3,
                  fontWeight: FontWeight.w900,
                ),
              );
            }
          },
        ),
      ],
    );
  }
}