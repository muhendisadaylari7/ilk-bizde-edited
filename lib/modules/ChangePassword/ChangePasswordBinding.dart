// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:ilkbizde/modules/ChangePassword/ChangePasswordController.dart';

class ChangePasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChangePasswordController>(() => ChangePasswordController());
  }
}
