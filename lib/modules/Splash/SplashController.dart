import 'package:get/get.dart';
import 'package:ilkbizde/routes/app_pages.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    redirect();
  }

  Future<void> redirect() async {
    await Future.delayed(const Duration(seconds: 1));
    Get.toNamed(Routes.NAVBAR);
  }
}
