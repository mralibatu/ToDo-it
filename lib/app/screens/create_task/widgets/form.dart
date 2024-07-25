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
    FocusScopeNode currentFocus = FocusScope.of(context);
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
            onEditingComplete: () {
              currentFocus.focusedChild!.unfocus();
            },
            onChanged: (text) {
              createTaskController.desc = text;
            },
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
        //Start Pop-up Menu
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
                      style: TextStyle(color: Colors.grey[850]),
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
            child: getPriorityText(selectedPriority),
          ),
        ),
        //End Pop-up Menu
        SizedBox(
          height: 40,
          child: Container(
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Text getPriorityText(Priority selectedPriority) {
    switch (selectedPriority) {
      case Priority.basic:
        return Text(
          "Basic",
          style: TextStyle(color: Colors.grey[850]),
        );
      case Priority.urgent:
        return Text(
          "Urgent",
          style: TextStyle(color: Colors.red[400]),
        );
      case Priority.important:
        return Text(
          "Important",
          style: TextStyle(color: Colors.orange[600]),
        );
      case Priority.urgentImportant:
        return Text(
          "Urgent & Important",
          style: TextStyle(color: Colors.red[900]),
        );
    }
  }
}
