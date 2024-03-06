import 'package:get/get.dart';
import 'package:ilkbizde/modules/NotificationSettings/NotificationSettingsController.dart';

class NotificationSettingsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationSettingsController>(
      () => NotificationSettingsController(),
    );
  }
}
