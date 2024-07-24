import 'package:get/get.dart';
import 'package:is_first_run/is_first_run.dart';

class SplashController extends GetxController {

  bool firstRun = true;

  @override
  void onInit() {
    super.onInit();
    loadIsFirst();
  }

  Future<void> loadIsFirst() async {
    firstRun = await IsFirstRun.isFirstRun();
  }
}