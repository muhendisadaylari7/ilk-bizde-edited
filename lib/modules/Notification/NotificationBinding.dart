import 'package:get/get.dart';
import 'package:ilkbizde/modules/Notification/NotificationController.dart';

class NotificationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationController>(() => NotificationController());
  }
}
