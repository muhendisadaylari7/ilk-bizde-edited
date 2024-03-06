// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:ilkbizde/modules/Showcase/ShowcaseController.dart';

class ShowcaseBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ShowcaseController>(ShowcaseController());
  }
}
