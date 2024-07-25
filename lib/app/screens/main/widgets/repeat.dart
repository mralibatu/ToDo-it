import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hold_to_confirm_button/hold_to_confirm_button.dart';

import '../../../data/local/models/task_model.dart';
import '../main_controller.dart';

class CardRepeat extends StatefulWidget {
  const CardRepeat({required this.task, super.key});

  final Task task;

  @override
  State<CardRepeat> createState() => _CardRepeatState();
}

class _CardRepeatState extends State<CardRepeat> {
  int repeat = -1;
  bool holdButtonShow = false;

  @override
  void initState() {
    repeat = widget.task.repeatFreq;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      init: MainController(),
      builder: (mainController) {
        return Row(
          children: [
            GestureDetector(
              onTap: () {
                repeatIncrement();
              },
              child: Icon(Icons.repeat),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(
                    mainController.getRepeatFreqTitle(repeat!),
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                holdButtonShow ?
                GestureDetector(
                  onTap: () {
                    mainController.createRepeatTask(widget.task, 0);
                  },
                  child:
                  SizedBox(
                    height: 30,
                    width: 100,
                    child: HoldToConfirmButton(
                      backgroundColor: Colors.grey[700]!,
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      contentPadding: EdgeInsets.all(5),
                      onProgressCompleted: () {
                        setState(() {
                          holdButtonShow = false;
                          mainController.createRepeatTask(widget.task, repeat);
                        });
                      },
                      child: Center(
                        child: const Text('Hold to save',
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ),
                    ),
                  ),
                ): SizedBox()
              ],
            )
          ],
        );
      },
    );
  }

  void repeatIncrement() {
    setState(() {
      repeat += 1;
      holdButtonShow = true;
      if (repeat > 3) {
        repeat = -1;
        holdButtonShow = false;
      }
    });
  }
}
