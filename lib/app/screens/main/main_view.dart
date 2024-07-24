import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:todo_it/app/routes/pages.dart';
import 'package:todo_it/app/screens/main/widgets/date_picker.dart';
import 'package:todo_it/app/screens/main/widgets/header.dart';
import 'package:todo_it/app/screens/main/widgets/list_task.dart';
import 'package:todo_it/app/screens/main/main_controller.dart';
import 'package:todo_it/app/screens/main/widgets/search.dart';
import 'package:todo_it/app/screens/main/widgets/sort_buttons.dart';

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  // @override
  // void initState() {
  //   taskRepository.createTasks(120);
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Column(children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Header(),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
            child: Search(),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: GetBuilder<MainController>(
                init: MainController(),
                builder: (mainController) {
                  return mainController.isDatepickerShow
                      ? const DatePickerWidget()
                      : const SizedBox();
                }),
          ),
          const SortButtons(),
          GetBuilder<MainController>(
            init: MainController(),
            builder: (mainController) {
              return mainController.list_task.isEmpty
                  ? const Text("There is no task!")
                  : ListTask(tasks: mainController.list_task);
            },
          ),
        ]),
      ),
      floatingActionButton: GetBuilder<MainController>(
          init: MainController(),
          builder: (mainController) {
            return FloatingActionButton(
              backgroundColor: const Color(0xff13678A),
              tooltip: 'Increment',
              onPressed: () async {
                print(Pages.createNewTask);
                final newTask = await Get.toNamed(Pages.createNewTask);

                if (newTask != null) {
                  mainController.addTask(newTask);
                  await mainController.resetTasks();
                  mainController.changeList();
                } else {
                  print("There is no task on return");
                }
              },
              child: const Icon(Icons.add_task_outlined,
                  color: Colors.white, size: 28),
            );
          }),
    );
  }
}
