// ignore_for_file: file_names

import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:ilkbizde/data/model/ForgotPasswordModel.dart';
import 'package:ilkbizde/data/network/api/ForgotPasswordApi.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/extensions/CustomSnackbar.dart';

class ForgotPasswordController extends GetxController {
  RxBool isLoading = false.obs;

  final TextEditingController emailController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)*$');

  @override
  void onClose() {
    super.onClose();
    emailController.dispose();
  }

  void handleForgotPassword() async {
    isLoading.toggle();
    final ForgotPasswordApi forgotPasswordApi = ForgotPasswordApi();
    final ForgotPasswordModel forgotPasswordModel = ForgotPasswordModel(
      email: emailController.text.trim(),
      secretKey: dotenv.env["SECRET_KEY"].toString(),
    );
    try {
      await forgotPasswordApi
          .handleForgotPassword(data: forgotPasswordModel.toJson())
          .then((resp) async {
        if (resp.data["status"] == "success") {
          isLoading.toggle();
          emailController.clear();
          SnackbarType.success.CustomSnackbar(
              title: AppStrings.success, message: resp.data["message"]);
          await Future.delayed(const Duration(seconds: 2), () => Get.back());
        } else if (resp.data["status"] == "warning") {
          isLoading.toggle();
          emailController.clear();
          SnackbarType.error.CustomSnackbar(
              title: AppStrings.error, message: resp.data["message"]);
          await Future.delayed(const Duration(seconds: 2), () => Get.back());
        }
      });
    } catch (e) {
      isLoading.toggle();
      print("handleForgotPassword error : $e");
    }
  }
}
