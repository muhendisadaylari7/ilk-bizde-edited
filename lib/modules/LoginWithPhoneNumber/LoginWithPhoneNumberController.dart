// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ilkbizde/data/model/LoginWithPhoneNumberRequestModel.dart';
import 'package:ilkbizde/data/model/PhoneLoginSendCodeRequestModel.dart';
import 'package:ilkbizde/data/network/api/LoginWithPhoneNumberApi.dart';
import 'package:ilkbizde/data/network/api/PhoneLoginSendCodeApi.dart';
import 'package:ilkbizde/routes/app_pages.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/extensions/CustomSnackbar.dart';
import 'package:sms_autofill/sms_autofill.dart';

class LoginWithPhoneNumberController extends GetxController with CodeAutoFill {
  final GetStorage storage = GetStorage();
  final PageController pageController = PageController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final RxString phoneNumber = "0".obs;
  final RxBool isLoading = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await SmsAutoFill().listenForCode();
  }

  @override
  void onClose() {
    super.onClose();
    phoneNumberController.dispose();
    pinCodeController.dispose();
    SmsAutoFill().unregisterListener();
  }

  Future<void> sendCode() async {
    isLoading.toggle();
    final PhoneLoginSendCodeApi phoneLoginSendCodeApi = PhoneLoginSendCodeApi();
    final PhoneLoginSendCodeRequestModel phoneLoginSendCodeRequestModel =
        PhoneLoginSendCodeRequestModel(
      secretKey: dotenv.env["SECRET_KEY"].toString(),
      telNo: "0${phoneNumberController.text}",
    );

    try {
      await phoneLoginSendCodeApi
          .sendCode(data: phoneLoginSendCodeRequestModel.toJson())
          .then((resp) async {
        if (resp.data["status"] == "success") {
          phoneNumber.value = "0${phoneNumberController.text}";
          SnackbarType.success.CustomSnackbar(
              title: AppStrings.success,
              message: resp.data["message"].toString());
          await Future.delayed(const Duration(seconds: 2), () => Get.back());
          pageController.nextPage(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeIn,
          );
          await SmsAutoFill().listenForCode();
        } else if (resp.data["status"] == "warning") {
          SnackbarType.error.CustomSnackbar(
            title: AppStrings.error,
            message: resp.data["message"].toString(),
          );
          await Future.delayed(const Duration(seconds: 2), () => Get.back());
        }
      });
    } catch (e) {
      isLoading.toggle();
      print("sendCode() error: $e");
    } finally {
      pinCodeController.clear();
      isLoading.toggle();
    }
  }

  Future<void> loginWithPhoneNumber() async {
    isLoading.toggle();
    final LoginWithPhoneNumberApi loginWithPhoneNumberApi =
        LoginWithPhoneNumberApi();
    final LoginWithPhoneNumberRequestModel loginWithPhoneNumberRequestModel =
        LoginWithPhoneNumberRequestModel(
      secretKey: dotenv.env["SECRET_KEY"].toString(),
      telNo: phoneNumber.value,
      telOnay: pinCodeController.text,
    );

    try {
      await loginWithPhoneNumberApi
          .loginWithPhoneNumber(data: loginWithPhoneNumberRequestModel.toJson())
          .then((resp) async {
        if (resp.data["status"] == "success") {
          isLoading.toggle();
          storage.write("uid", resp.data["userId"]);
          storage.write("uEmail", resp.data["userEmail"]);
          storage.write("uPassword", resp.data["userPassword"]);
          Get.offNamed(Routes.NAVBAR);
        } else if (resp.data["status"] == "warning") {
          SnackbarType.error.CustomSnackbar(
            title: AppStrings.error,
            message: resp.data["message"].toString(),
          );
          await Future.delayed(const Duration(seconds: 2), () => Get.back());
        }
      });
    } catch (e) {
      isLoading.toggle();
      print("loginWithPhoneNumber() error: $e");
    } finally {
      isLoading.toggle();
    }
  }

  @override
  void codeUpdated() {
    pinCodeController.text = code!;
  }
}
