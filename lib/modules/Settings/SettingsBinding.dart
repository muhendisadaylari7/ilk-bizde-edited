import 'package:get/get.dart';
import 'package:ilkbizde/modules/Settings/SettingsController.dart';

class SettingsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingsController>(() => SettingsController());
  }
}
