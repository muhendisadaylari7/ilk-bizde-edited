// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:ilkbizde/controllers/NetworkController.dart';

class NetworkBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NetworkController>(() => NetworkController());
  }
}
