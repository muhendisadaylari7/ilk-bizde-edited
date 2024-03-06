// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:ilkbizde/modules/BlogDetail/BlogDetailController.dart';

class BlogDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BlogDetailController>(() => BlogDetailController());
  }
}
