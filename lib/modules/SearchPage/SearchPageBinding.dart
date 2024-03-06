// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:ilkbizde/modules/SearchPage/SearchPageController.dart';

class SearchPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchPageController>(() => SearchPageController());
  }
}
