// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:ilkbizde/modules/News/NewsController.dart';

class NewsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewsController>(() => NewsController());
  }
}
