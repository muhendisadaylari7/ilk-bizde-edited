// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:ilkbizde/modules/ForgotPassword/ForgotPasswordController.dart';

class ForgotPasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotPasswordController>(() => ForgotPasswordController());
  }
}
