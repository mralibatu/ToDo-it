import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:segmented_button_slide/segmented_button_slide.dart';
import 'package:todo_it/app/screens/main/main_controller.dart';

class SortButtons extends StatefulWidget {
  const SortButtons({super.key});

  @override
  State<SortButtons> createState() => _SortButtonsState();
}

class _SortButtonsState extends State<SortButtons> {

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: 80,
      width: 500,
      child: GetBuilder<MainController>(
        builder: (mainController) {
          return SegmentedButtonSlide(
            entries: mainController.isDatepickerShow
                ? [
              const SegmentedButtonSlideEntry(
                  icon: Icons.sort, label: "Priority"),
              const SegmentedButtonSlideEntry(icon: Icons.sort, label: "Done"),
            ]
                : [
              const SegmentedButtonSlideEntry(
                  icon: Icons.sort, label: "Priority"),
              const SegmentedButtonSlideEntry(icon: Icons.sort, label: "Date"),
              const SegmentedButtonSlideEntry(icon: Icons.sort, label: "Done"),
            ],
            selectedEntry: mainController.selectedOption,
            onChange: (selected) {
              mainController.changeSelectedOption(selected);
            },
            colors: SegmentedButtonSlideColors(
              barColor: Colors.grey.withOpacity(0.2),
              backgroundSelectedColor: const Color(0xff5e9e9d),
              foregroundSelectedColor: Colors.white,
              foregroundUnselectedColor: Colors.black,
              hoverColor: Colors.grey.withOpacity(0.8),
            ),
            slideShadow: const [
              BoxShadow(
                  color: Colors.white54, blurRadius: 5, spreadRadius: 1)
            ],
            margin: const EdgeInsets.all(16),
            height: 40,
          );
        },
      ),
    );
  }
}
