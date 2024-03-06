// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:ilkbizde/modules/CategoryResultPage/CategoryResultPageController.dart';

class CategoryResultPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategoryResultPageController>(
        () => CategoryResultPageController());
  }
}
