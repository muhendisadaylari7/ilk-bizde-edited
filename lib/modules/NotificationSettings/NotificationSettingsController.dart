import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class NotificationSettingsController extends GetxController {
  final GetStorage storage = GetStorage();

  final RxBool isNotificationAllowed = false.obs;

  @override
  void onInit() {
    isNotificationAllowed.value =
        storage.read("isNotificationAllowed") ?? false;
    super.onInit();
  }
}
