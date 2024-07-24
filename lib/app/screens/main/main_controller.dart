import 'package:get/get.dart';
import 'package:todo_it/app/data/repository/task_repository.dart';
import 'package:todo_it/app/Constants/constants.dart';

import '../../data/local/models/task_model.dart';

class MainController extends GetxController {
  TaskRepository taskRepository =
      TaskRepository(taskProvider: Constants.dbContext);
  bool isDatepickerShow = false;
  DateTime? selectedDate;
  List<Task> list_task = [];
  int selectedOption = 0;

  Future<void> setSelectedDate(DateTime date) async {
    await resetTasks();
    selectedDate = date;
    print("Selected date : $selectedDate");
    list_task = await taskRepository.getByDate(selectedOption, selectedDate!,
        tasks: list_task);
    print("Returned tasks count by selected date : ${list_task.length}");
    update();
  }

  bool getIsDatepickerShow() {
    return isDatepickerShow;
  }

  void toggleDatepickerShow() {
    isDatepickerShow = !isDatepickerShow;
    if(isDatepickerShow)
      {
        print("Date picker opened");
        selectedDate = DateTime.now();
        changeList();
      }else{
      print("Date picker closed");
    }
    update();
  }

  @override
  void onInit() {
    super.onInit();
    loadTasks();
  }

  Future<void> loadTasks() async {
    list_task = await taskRepository.getTasks();
    update();
  }

  void setTasks(List<Task> tasks) {
    list_task = tasks;
  }

  Future<void> deleteTask(Task task) async {
    await taskRepository.deleteTask(task);
    print("Task deleted");
    if(selectedDate != null)
    {
      DateTime selectedDateTemp = selectedDate ?? DateTime.now();
      resetTasks();
      selectedDate = selectedDateTemp;
    }else{
      resetTasks();
    }
    changeList();
  }

  Future<void> toggleCompletedTask(Task task)
  async {
    //print("Before toggle " + task.isCompleted.toString());
    task.isCompleted = !task.isCompleted!;
    final updatedTask = task.copyWith(task);
    //print("After toggle " + updatedTask.isCompleted.toString());
    await taskRepository.updateTask(updatedTask);
    if(selectedDate != null)
      {
        DateTime selectedDateTemp = selectedDate ?? DateTime.now();
        resetTasks();
        selectedDate = selectedDateTemp;
      }else{
      resetTasks();
    }

    changeList();
  }

  void addTask(Task task)
  {
    taskRepository.createNewTask(task);
    print("Task added");
    resetTasks();
    changeList();
  }

  Future<void> resetTasks() async {
    print("Task list restarted");
    selectedDate = null;
    list_task = await taskRepository.getTasks();
  }

  void search(String query) async {
    print("Query : $query");
    if (query == "" || query.isEmpty) {
      changeList();
      return;
    }
    //When delete some char and write through it, there is a list bug
    list_task = list_task
        .where((e) => e.title!.toLowerCase().contains(query.toLowerCase()))
        .toList();

    print("List changed\nNew list count : ${list_task.length}");

    update();
  }

  void changeSelectedOption(int selectedOption) {
    this.selectedOption = selectedOption;
    print("Option changed to : $selectedOption");
    changeList();
  }

  void changeList() async {
    print("Changed list");
    if (selectedDate != null) {
      setSelectedDate(selectedDate!);
    } else {
      switch (selectedOption) {
        case 0:
          list_task = await taskRepository.sortByPriority();
        case 1:
          list_task = await taskRepository.sortByDate();
        case 2:
          list_task = await taskRepository.getCompleted();
      }
    }

    print("Returned task count : ${list_task.length}");
    update();
  }
}
