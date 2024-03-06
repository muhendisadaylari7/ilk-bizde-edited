// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:ilkbizde/modules/Signup/SignupController.dart';

class SignupBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignupController>(() => SignupController());
  }
}
