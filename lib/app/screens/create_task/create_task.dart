import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_it/app/screens/create_task/widgets/calendar_picker.dart';
import 'package:todo_it/app/screens/create_task/create_task_controller.dart';
import 'package:uuid/uuid.dart';

import '../../data/local/models/task_model.dart';
import 'widgets/form.dart';

class CreateTask extends StatefulWidget {
  const CreateTask({super.key});

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  @override
  Widget build(BuildContext context) {
    CreateTaskController createTaskController =
        Get.find<CreateTaskController>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[200],
        title: const Text("Create task"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          const CalendarPicker(),
          SizedBox(
            height: 20,
            child: Container(
              color: Colors.white,
            ),
          ),
          const CalendarForm()
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff13678A),
        tooltip: 'Increment',
        onPressed: () {
          if (createTaskController.title == null ||
              createTaskController.desc == null ||
              createTaskController.startDate == null) {
            return;
          }

          var uuid = const Uuid();
          String newId = uuid.v4();

          Task newTask = Task(
            id: newId,
            title: createTaskController.title,
            description: createTaskController.desc,
            startDate: createTaskController.startDate,
            priority: createTaskController.priority,
            isCompleted: false,
            repeatFreq: -1,
            repeatId: "",
          );

          Get.back(result: newTask);
        },
        child: const Icon(Icons.save, color: Colors.white, size: 28),
      ),
    );
  }
}
