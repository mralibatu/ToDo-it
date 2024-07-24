import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_it/app/data/repository/task_repository.dart';
import 'package:todo_it/app/Constants/constants.dart';

import '../main_controller.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();
  final TaskRepository taskRepository =
      TaskRepository(taskProvider: Constants.dbContext);

  @override
  void initState() {
    searchController.addListener(queryListener);
    super.initState();
  }

  void queryListener() {
    taskRepository.search(searchController.text);
  }

  @override
  void dispose() {
    searchController.removeListener(queryListener);
    searchController.dispose();
    searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MainController mainController = Get.find<MainController>();

    return SizedBox(
      width: 400,
      height: 50,
      child: SearchBar(
        autoFocus: false,
        controller: searchController,
        hintText: "Search",
        leading: const Padding(
          padding: EdgeInsets.only(left: 15),
          child: Icon(Icons.search),
        ),
        onChanged: (String value) async {
          mainController.search(value);
        },
        onSubmitted: (String value) {},
      ),
    );
  }
}
