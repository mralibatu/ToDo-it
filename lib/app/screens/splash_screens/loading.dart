import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_it/app/routes/pages.dart';
import 'package:todo_it/app/screens/splash_screens/splash_controller.dart';

class LoadingSplash extends StatefulWidget {
  const LoadingSplash({super.key});

  @override
  State<LoadingSplash> createState() => _LoadingSplashState();
}

class _LoadingSplashState extends State<LoadingSplash> {
  SplashController splashController = Get.find<SplashController>();

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      if (splashController.firstRun) {
        Get.offNamed(Pages.introduction);
      }else{
        Get.offNamed(Pages.home);
      }
       // Replace '/newRoute' with your target route
    });
  }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.fill,
        child: Image.asset("assets/gifs/loading.gif"));
  }
}
