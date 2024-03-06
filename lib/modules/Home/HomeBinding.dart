// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:ilkbizde/modules/Home/HomeController.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<HomeController>(HomeController());
  }
}
