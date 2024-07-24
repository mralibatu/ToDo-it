import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_it/app/screens/create_task/create_task_controller.dart';

import '../../../data/local/enums/priority_enum.dart';

class CalendarForm extends StatefulWidget {
  const CalendarForm({super.key});

  @override
  State<CalendarForm> createState() => _CalendarFormState();
}

class _CalendarFormState extends State<CalendarForm> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  Priority selectedPriority = Priority.basic;

  @override
  Widget build(BuildContext context) {
    CreateTaskController createTaskController =
        Get.find<CreateTaskController>();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: TextField(
            onChanged: (text) {
              createTaskController.title = text;
            },
            controller: titleController,
            decoration: const InputDecoration(
              labelText: 'Task Title',
              hintText: 'Meet with Alex',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        SizedBox(
          height: 20,
          child: Container(
            color: Colors.white,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: TextField(
            onChanged: (text) {
              createTaskController.desc = text;
            },
            keyboardType: TextInputType.multiline,
            maxLines: null,
            controller: descController,
            decoration: const InputDecoration(
              labelText: 'Task Description',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        SizedBox(
          height: 20,
          child: Container(
            color: Colors.white,
          ),
        ),
        SizedBox(
          height: 50,
          width: 200,
          child: TextButton(
            onPressed: () {
              // Show popup menu
              showMenu(
                context: context,
                position: const RelativeRect.fromLTRB(50, 600, 30, 200),
                items: [
                  PopupMenuItem<String>(
                    value: "basic",
                    child: Text(
                      "Basic",
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: "urgent",
                    child: Text(
                      "Urgent",
                      style: TextStyle(color: Colors.red[400]),
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: "important",
                    child: Text(
                      "Important",
                      style: TextStyle(color: Colors.orange[600]),
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: "urgentImportant",
                    child: Text(
                      "Urgent & Important",
                      style: TextStyle(color: Colors.red[900]),
                    ),
                  ),
                ],
              ).then((value) {
                if (value != null) {
                  selectedPriority = Priority.values.byName(value);
                  createTaskController.priority = selectedPriority;
                }
              });
            },
            child: Text(selectedPriority.name.toString().toUpperCase()),
          ),
        ),
        SizedBox(
          height: 40,
          child: Container(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
