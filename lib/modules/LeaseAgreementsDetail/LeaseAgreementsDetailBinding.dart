// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:ilkbizde/modules/LeaseAgreementsDetail/LeaseAgreementsDetailController.dart';

class LeaseAgreementsDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LeaseAgreementsDetailController>(
        () => LeaseAgreementsDetailController());
  }
}
