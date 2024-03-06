// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:ilkbizde/modules/AdsPublish/index.dart';

class AdsPublishBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdsPublishController>(() => AdsPublishController());
  }
}
