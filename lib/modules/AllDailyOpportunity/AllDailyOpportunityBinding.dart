// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:ilkbizde/modules/AllDailyOpportunity/AllDailyOpportunityController.dart';

class AllDailyOpportunityBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllDailyOpportunityController>(
        () => AllDailyOpportunityController());
  }
}
