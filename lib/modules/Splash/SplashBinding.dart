// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:ilkbizde/modules/Splash/SplashController.dart';

class SplashBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(() => SplashController());
  }
}
