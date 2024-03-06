import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ilkbizde/data/model/GeneralRequestModel.dart';
import 'package:ilkbizde/data/network/api/DeleteAccountApi.dart';
import 'package:ilkbizde/routes/app_pages.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/extensions/CustomSnackbar.dart';
import 'package:ilkbizde/shared/widgets/index.dart';

class SettingsController extends GetxController {
  final GetStorage storage = GetStorage();

  final RxBool isDeleteLoading = false.obs;

  void createDeleteAccountDialog() {
    Get.dialog(
      Obx(
        () => CustomAreUSureDialog(
          title: "Hesabınızı silmek istediğinize emin misiniz?",
          isLoading: isDeleteLoading.value,
          yesOnTap: () => handleDeleteAccount(),
        ),
      ),
    );
  }

// HESABIMI SİL
  Future<void> handleDeleteAccount() async {
    isDeleteLoading.toggle();
    final DeleteAccountApi deleteAccountApi = DeleteAccountApi();
    final GeneralRequestModel generalRequestModel = GeneralRequestModel(
      secretKey: dotenv.env['SECRET_KEY'].toString(),
      userId: storage.read("uid"),
      userEmail: storage.read("uEmail"),
      userPassword: storage.read("uPassword"),
    );

    try {
      await deleteAccountApi
          .handleDeleteAccount(data: generalRequestModel.toJson())
          .then((resp) async {
        if (resp.data["status"] == "success") {
          storage.erase();
          await Get.deleteAll(force: true);
          Get.toNamed(Routes.SPLASH);
          SnackbarType.success.CustomSnackbar(
              title: AppStrings.success, message: resp.data["message"]);
          await Future.delayed(Duration(seconds: 2), () => Get.back());
        } else if (resp.data["status"] == "warning") {
          SnackbarType.error.CustomSnackbar(
              title: AppStrings.error, message: resp.data["message"]);
          await Future.delayed(Duration(seconds: 2), () => Get.back());
        }
      });
    } catch (e) {
      isDeleteLoading.toggle();
      print("handleDeleteAccount error: $e");
    } finally {
      isDeleteLoading.toggle();
    }
  }
}
