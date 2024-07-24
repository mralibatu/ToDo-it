import 'package:get/get.dart';
import 'package:todo_it/app/screens/calendar/calendar_controller.dart';
import 'package:todo_it/app/screens/create_task/create_task_controller.dart';
import 'package:todo_it/app/screens/main/main_controller.dart';
import '../screens/splash_screens/splash_controller.dart';

class RootBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<SplashController>(SplashController());
    Get.put<MainController>(MainController());
    Get.put<CreateTaskController>(CreateTaskController());
    Get.put<CalendarController>(CalendarController());
  }
}