// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:ilkbizde/modules/MyAccount/MyAccountController.dart';

class MyAccountBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyAccountController>(() => MyAccountController());
  }
}
