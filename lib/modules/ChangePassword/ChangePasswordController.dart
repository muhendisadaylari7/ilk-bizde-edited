// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ilkbizde/data/model/ChangePasswordModel.dart';
import 'package:ilkbizde/data/network/api/ChangePasswordApi.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/extensions/CustomSnackbar.dart';

class ChangePasswordController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isVisible = false.obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final GetStorage storage = GetStorage();

  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController newPasswordAgainController =
      TextEditingController();

  Future<void> handleChangePassword() async {
    isLoading.toggle();
    final ChangePasswordApi changePasswordApi = ChangePasswordApi();
    final ChangePasswordModel changePasswordModel = ChangePasswordModel(
      userId: storage.read("uid"),
      newPassword2: newPasswordAgainController.text,
      secretKey: dotenv.env["SECRET_KEY"].toString(),
      userEmail: storage.read("uEmail"),
      userPassword: storage.read("uPassword"),
      currentPassword: currentPasswordController.text,
      newPassword: newPasswordController.text,
    );
    try {
      await changePasswordApi
          .handlChangePassword(data: changePasswordModel.toJson())
          .then((resp) async {
        if (resp.data["status"] == "success") {
          isLoading.toggle();
          storage.write("uPassword", resp.data["newPassword"]);
          SnackbarType.success.CustomSnackbar(
              title: AppStrings.success, message: resp.data["message"]);
          await Future.delayed(const Duration(seconds: 2), () => Get.back());
        } else if (resp.data["status"] == "warning") {
          isLoading.toggle();
          SnackbarType.error.CustomSnackbar(
              title: AppStrings.error, message: resp.data["message"]);
          await Future.delayed(const Duration(seconds: 2), () => Get.back());
        }
      });
    } catch (e) {
      isLoading.toggle();
    }
  }

  @override
  void onClose() {
    super.onClose();
    currentPasswordController.dispose();
    newPasswordController.dispose();
    newPasswordAgainController.dispose();
  }
}
