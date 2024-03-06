// ignore_for_file: file_names

import 'package:get/get.dart';

import 'LeaseAgreementsController.dart';

class LeaseAgreementsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LeaseAgreementsController>(() => LeaseAgreementsController());
  }
}
