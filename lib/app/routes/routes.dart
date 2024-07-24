import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:todo_it/app/routes/pages.dart';
import 'package:todo_it/app/screens/splash_screens/introduction_screen.dart';
import 'package:todo_it/app/screens/splash_screens/loading.dart';
import '../screens/calendar/calendar_page.dart';
import '../screens/create_task/create_task.dart';
import '../screens/main/main_view.dart';

class Routes {
  static final routes = [
    GetPage(name: Pages.initial, page: () => const LoadingSplash()),
    GetPage(name: Pages.introduction, page: () => const IntroductionScreen()),
    GetPage(name: Pages.home, page: () => const Main()),
    GetPage(name: Pages.createNewTask, page: () => const CreateTask()),
    GetPage(name: Pages.calendar, page: () => const CalendarPage()),
  ];
}
