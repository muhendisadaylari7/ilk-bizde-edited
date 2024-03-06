import 'package:get/get.dart';
import 'package:ilkbizde/modules/MyOpportunity/MyOpportunityController.dart';

class MyOpportunityBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyOpportunityController>(() => MyOpportunityController());
  }
}
