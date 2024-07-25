import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_it/app/screens/main/main_controller.dart';
import 'package:todo_it/app/screens/main/main_view.dart';
import 'package:todo_it/app/screens/main/widgets/card_date.dart';
import 'package:todo_it/app/screens/main/widgets/card_icon.dart';
import 'package:todo_it/app/screens/main/widgets/repeat.dart';

import '../../../commons/common.dart';
import '../../../data/local/enums/priority_enum.dart';
import '../../../data/local/models/task_model.dart';
import 'card_expand.dart';

class ListTask extends StatefulWidget {
  final List<Task> tasks;

  const ListTask({super.key, required this.tasks});

  @override
  State<ListTask> createState() => _ListTaskState();
}

class _ListTaskState extends State<ListTask> {
  @override
  Widget build(BuildContext context) {
    MainController mainController = Get.find<MainController>();
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView.builder(
          itemCount: widget.tasks.length,
          itemBuilder: (context, index) {
            return Dismissible(
              //Slide operations
              key: UniqueKey(),
              direction: DismissDirection.endToStart,
              background: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.blue,
                ),
                //Completed slider background
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 20.0),
                child: const Icon(Icons.edit_calendar, color: Colors.white),
              ),
              secondaryBackground: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.red,
                ),
                //Delete slider background
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 20.0),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              confirmDismiss: (direction) async {
                if (direction == DismissDirection.startToEnd) {
                  Navigator.pushNamed(context, "/edit-task",
                      arguments: widget.tasks[index]);
                } else if (direction == DismissDirection.endToStart) {
                  setState(() {
                    mainController.deleteTask(widget.tasks[index]);
                    widget.tasks.removeAt(index);
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Task silindi')),
                  );
                }
                return null;
              },

              child: Card(
                child: ListTile(
                  leading: IconButton(
                    onPressed: () {
                      setState(() {
                        print("Repeat Id ${widget.tasks[index].repeatId}");
                        mainController.toggleCompletedTask(widget.tasks[index]);
                        widget.tasks[index].isCompleted =
                            !widget.tasks[index].isCompleted!;
                      });
                    },
                    icon: Icon(
                      widget.tasks[index].isCompleted!
                          ? Icons.check_box
                          : Icons.check_box_outline_blank,
                      color: const Color(0xff3fa5a4),
                    ),
                  ),
                  title: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.tasks[index].title!,
                            style: const TextStyle(color: Color(0xff024059)),
                          ),
                          IconButton(
                            onPressed: () =>
                                showAlertDialog(context, widget.tasks[index]),
                            icon: CardIcon(
                              task: widget.tasks[index],
                            ),
                          )
                        ],
                      ),
                      GetBuilder<MainController>(
                        init: MainController(),
                        builder: (mainController) {
                          return mainController.isDatepickerShow
                              ? CardRepeat(task: widget.tasks[index])
                              : CardExpand(task: widget.tasks[index]);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
showAlertDialog(BuildContext context, Task task) {
  return showAdaptiveDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Row(
        children: [
          Text("${task.title}"),
          const SizedBox(
            width: 10,
          ),
          CardIcon(
            task: task,
          ),
        ],
      ),
      content: Text("${task.description}"),
    ),
  );
}
