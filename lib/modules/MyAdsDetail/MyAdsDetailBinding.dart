// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:ilkbizde/modules/MyAdsDetail/MyAdsDetailController.dart';

class MyAdsDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyAdsDetailController>(() => MyAdsDetailController());
  }
}
