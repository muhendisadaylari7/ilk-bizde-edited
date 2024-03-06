import 'package:get/get.dart';
import 'package:ilkbizde/modules/PrivacyAndPolicy/PrivacyAndPolicyController.dart';

class PrivacyAndPolicyBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PrivacyAndPolicyController>(() => PrivacyAndPolicyController());
  }
}
