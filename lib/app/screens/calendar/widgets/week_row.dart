import 'package:flutter/material.dart';

class WeekRow extends StatelessWidget {
  const WeekRow({
    super.key,
    required this.days,
  });

  final List<Widget> days;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: days.length,
        itemBuilder: (context, index) {
          return Align(
            alignment: Alignment.topCenter,
            child: Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 15, 0),
                  child: days[index],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}