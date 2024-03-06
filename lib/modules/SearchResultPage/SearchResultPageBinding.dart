// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:ilkbizde/modules/SearchResultPage/SearchResultPageController.dart';

class SearchResultPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchResultPageController>(() => SearchResultPageController());
  }
}
