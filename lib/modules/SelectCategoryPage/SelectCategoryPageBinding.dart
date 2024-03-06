// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:ilkbizde/modules/SelectCategoryPage/SelectCategoryPageController.dart';

class SelectCategoryPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SelectCategoryPageController>(
        () => SelectCategoryPageController());
  }
}
