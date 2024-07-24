import 'package:todo_it/app/data/local/enums/priority_enum.dart';
import 'package:get/get.dart';

class CreateTaskController extends GetxController {
  DateTime? startDate;
  String? title;
  String? desc;
  Priority priority = Priority.basic;


  void selectDate(DateTime date)
  {
    startDate = date;
  }
}