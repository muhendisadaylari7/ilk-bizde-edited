// ignore: file_names
import 'package:get/get.dart';
import 'package:ilkbizde/modules/MyAds/MyAdsController.dart';

class MyAdsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyAdsController>(() => MyAdsController());
  }
}
