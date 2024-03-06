// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:ilkbizde/modules/AddLeaseAgreement/AddLeaseAgreementController.dart';

class AddLeaseAgreementBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddLeaseAgreementController>(
        () => AddLeaseAgreementController());
  }
}
