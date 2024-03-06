// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:ilkbizde/modules/Blog/BlogController.dart';

class BlogBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BlogController>(() => BlogController());
  }
}
