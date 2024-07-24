import 'package:animate_icons/animate_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_it/app/routes/pages.dart';

import '../main_controller.dart';

class Header extends StatefulWidget {
  const Header({super.key});
  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  final AnimateIconController iconController = AnimateIconController();

  @override
  Widget build(BuildContext context) {
    MainController mainController = Get.find<MainController>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, Pages.calendar);
                },
                icon: const Icon(Icons.calendar_month), iconSize: 30, color: Colors.black87,),

            ],
          ),
        ),
        const Text(
          "To-Do it!",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: AnimateIcons(
            startIcon: Icons.select_all,
            endIcon: Icons.calendar_view_day_rounded,
            size: 30.0,
            controller: iconController,
            // add this tooltip for the start icon
            startTooltip: 'Icons.add_circle',
            // add this tooltip for the end icon
            endTooltip: 'Icons.add_circle_outline',
            onStartIconPress: () {
              mainController.toggleDatepickerShow();
              return true;
            },
            onEndIconPress: () {
              mainController.resetTasks();
              mainController.toggleDatepickerShow();
              return true;
            },
            duration: const Duration(milliseconds: 200),
            startIconColor: Colors.black,
            endIconColor: Colors.black,
            clockwise: false,
          ),
        ),
      ],
    );
  }
}