// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:ilkbizde/modules/AdvertisementDetail/AdvertisementDetailController.dart';

class AdvertisementDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<AdvertisementDetailController>(AdvertisementDetailController());
  }
}
