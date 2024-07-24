import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_it/app/routes/main_binding.dart';
import 'package:todo_it/app/routes/routes.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialBinding: RootBinding(),
        getPages: Routes.routes,
      );
  }
}

