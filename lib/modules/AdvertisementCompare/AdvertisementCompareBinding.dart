// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:ilkbizde/modules/AdvertisementCompare/AdvertisementCompareController.dart';

class AdvertisementCompareBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdvertisementCompareController>(
      () => AdvertisementCompareController(),
    );
  }
}
