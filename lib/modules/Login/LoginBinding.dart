// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:ilkbizde/modules/Login/LoginController.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
  }
}
