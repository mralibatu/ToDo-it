import 'package:intl/intl.dart';

import '../data/local/models/task_model.dart';

int getDaysCount() {
  DateTime now = DateTime.now();
  DateTime lastDayOfMonth = DateTime(now.year, now.month + 1, 0);
  return lastDayOfMonth.day - now.day;
}

String getDayMonth(Task task) {
  return DateFormat("MMMEd").format(
    DateTime(
      task.startDate!.year,
      task.startDate!.month,
      task.startDate!.day,
    ),
  );
}

String getMonthName(int j) {
  DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('MMM');
  return formatter.format(DateTime(now.year, now.month + j));
}
