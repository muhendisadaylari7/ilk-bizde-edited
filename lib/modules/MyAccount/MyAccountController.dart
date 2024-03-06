// ignore_for_file: file_names

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ilkbizde/data/model/GeneralRequestModel.dart';
import 'package:ilkbizde/data/network/api/MarketControlApi.dart';
import 'package:ilkbizde/data/network/services/auth_service.dart';
import 'package:ilkbizde/modules/Home/HomeController.dart';
import 'package:ilkbizde/modules/PersonalInformation/index.dart';
import 'package:ilkbizde/routes/app_pages.dart';
import 'package:ilkbizde/shared/constants/theme.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class MyAccountController extends GetxController {
  final GetStorage storage = GetStorage();

  RxString nameSurname = "".obs;

  final PersonalInformationController personalInformationController =
      Get.put(PersonalInformationController());
  final HomeController homeController =
      Get.put<HomeController>(HomeController());

  Future<void> marketControl() async {
    final GeneralRequestModel generalRequestModel = GeneralRequestModel(
      secretKey: dotenv.env["SECRET_KEY"].toString(),
      userId: storage.read("uid"),
      userEmail: storage.read("uEmail"),
      userPassword: storage.read("uPassword"),
    );
    final MarketControlApi marketControlApi = MarketControlApi();
    try {
      await marketControlApi
          .marketControl(data: generalRequestModel.toJson())
          .then((resp) {
        if (resp.data["status"] == "success") {
          Get.toNamed(Routes.MYSTORE);
        } else {
          Get.toNamed(Routes.MYSTORE);
        }
      });
    } catch (e) {
      print("HATA: $e");
    }
  }

  Future<void> handleLogout() async {
    Get.offAllNamed(Routes.SPLASH);
    storage.remove("uid");
    storage.remove("uEmail");
    storage.remove("uPassword");
    await OneSignal.logout();
    await AuthService().googleSignOut();
    if (Get.isDarkMode) {
      Get.changeTheme(CustomTheme.lightTheme);
      homeController.isProPopup.toggle();
    }
    await Future.delayed(
      const Duration(milliseconds: 300),
      () async {
        await homeController.getCategories();
        await homeController.getDailyOpportunityAdvertisements();
        await homeController.getPopularAdvertisements();
      },
    );
  }

  String getAccountName(String accountTypeId) {
    switch (accountTypeId) {
      case "0":
        return "Bireysel Üyelik";
      case "1":
        return "Kurumsal Üyelik";
      default:
        return "";
    }
  }
}
