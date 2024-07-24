import 'package:get/get.dart';
import 'package:todo_it/app/Constants/constants.dart';
import 'package:todo_it/app/data/repository/task_repository.dart';

import '../../data/local/models/task_model.dart';

class CalendarController extends GetxController {
  TaskRepository taskRepository =
      TaskRepository(taskProvider: Constants.dbContext);
  bool isDarkMode = false;
  List<Task> fetchedTasks = [];
  int changeCalendarMonth = 0;
  DateTime currentDate = DateTime(DateTime.now().year, DateTime.now().month);

  @override
  void onInit() {
    loadTasks();
    currentDate = DateTime(
        DateTime.now().year, DateTime.now().month + changeCalendarMonth);
    super.onInit();
  }

  Future<void> loadTasks() async {
    fetchedTasks = await taskRepository.getTasks();
  }

  void toggleDarkMode() {
    isDarkMode = !isDarkMode;
  }

  void monthIncrease() {
    changeCalendarMonth += 1;
    currentDate = DateTime(
        DateTime.now().year, DateTime.now().month + changeCalendarMonth);
    update();
  }

  void monthDecrease() {
    changeCalendarMonth -= 1;
    currentDate = DateTime(
      DateTime.now().year,
      DateTime.now().month + changeCalendarMonth,
    );
    update();
  }

  Future<int> getTaskCount(int currentDay) async {
    DateTime filterDate = DateTime(currentDate.year, currentDate.month, currentDay);
    return await taskRepository.getTaskCountByDate(filterDate, true);
  }

  int getWeekDay() {
    DateTime now = DateTime.now();
    DateTime firstDayOfMonth =
        DateTime(now.year, now.month + changeCalendarMonth, 1);
    return firstDayOfMonth.weekday;
  }
}
