// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ilkbizde/data/model/AppleLoginRequestModel.dart';
import 'package:ilkbizde/data/model/AppleSignInUpdateNameSurnameModel.dart';
import 'package:ilkbizde/data/model/UserLoginModel.dart';
import 'package:ilkbizde/data/network/api/AppleSignInApi.dart';
import 'package:ilkbizde/data/network/api/AppleSignInUpdateNameSurnameApi.dart';
import 'package:ilkbizde/data/network/api/GoogleSignInApi.dart';
import 'package:ilkbizde/data/network/api/LoginApi.dart';
import 'package:ilkbizde/data/network/services/auth_service.dart';
import 'package:ilkbizde/routes/app_pages.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/extensions/CustomSnackbar.dart';
import 'package:ilkbizde/shared/widgets/index.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:sizer/sizer.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> nameSurnameFormKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();

  final GetStorage storage = GetStorage();

// NORMAL GİRİŞ
  Future<void> handleLogin() async {
    isLoading.toggle();
    final LoginApi loginApi = LoginApi();
    final UserLoginModel userLoginModel = UserLoginModel(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
      secretKey: dotenv.env["SECRET_KEY"].toString(),
    );
    try {
      await loginApi
          .handleLogin(data: userLoginModel.toJson())
          .then((resp) async {
        if (resp.data["status"] == "success") {
          storage.write("uid", resp.data["userId"]);
          storage.write("uEmail", resp.data["userEmail"]);
          storage.write("uPassword", resp.data["userPassword"]);
          emailController.clear();
          passwordController.clear();
          await OneSignal.login(resp.data["userId"]);
          Get.offNamed(Routes.NAVBAR);
        } else if (resp.data["status"] == "warning") {
          SnackbarType.error.CustomSnackbar(
              title: AppStrings.error, message: resp.data["message"]);
          await Future.delayed(const Duration(seconds: 2), () => Get.back());
        }
      });
    } catch (e) {
      isLoading.toggle();
      print("handleLogin error : $e");
    } finally {
      isLoading.toggle();
    }
  }

// GOOGLE İLE GİRİŞ YAP
  Future<void> handleGoogleSignIn() async {
    final GoogleSignInApi googleSignInApi = GoogleSignInApi();
    final String? accessToken = await AuthService().signInWithGoogle();
    try {
      isLoading.toggle();
      await googleSignInApi.handleGoogleSignIn(data: {
        "token": accessToken,
      }).then((resp) async {
        if (resp.data["status"] == "success") {
          storage.write("uid", resp.data["userId"]);
          storage.write("uEmail", resp.data["userEmail"]);
          storage.write("uPassword", resp.data["userPassword"]);
          await OneSignal.login(resp.data["userId"]);
          Get.offNamed(Routes.NAVBAR);
        } else if (resp.data["status"] == "warning") {
          SnackbarType.error.CustomSnackbar(
              title: AppStrings.error, message: resp.data["message"]);
          await Future.delayed(const Duration(seconds: 2), () => Get.back());
        }
      });
    } catch (e) {
      isLoading.toggle();
      print("handleGoogleSignIn error: $e");
    } finally {
      isLoading.toggle();
    }
  }

// APPLE İLE GİRİŞ YAP
  Future<void> handleAppleSignIn() async {
    final AppleSignInApi appleSignInApi = AppleSignInApi();
    final String? idToken = await AuthService().signInWithApple();
    final AppleLoginRequestModel appleLoginRequestModel =
        AppleLoginRequestModel(
            secretKey: dotenv.env["SECRET_KEY"].toString(),
            token: idToken ?? "",
            name: "",
            surname: "");
    try {
      isLoading.toggle();
      await appleSignInApi
          .handleAppleSignIn(data: appleLoginRequestModel.toJson())
          .then((resp) async {
        if ((resp.data["status"] == "success" &&
                resp.data["message"] == AppStrings.appleNameSurnameRequired) ||
            resp.data["message"] == AppStrings.appleNameSurnameRequired2) {
          SnackbarType.error.CustomSnackbar(
              title: AppStrings.loginTitle, message: resp.data["message"]);
          await Future.delayed(const Duration(seconds: 2), () => Get.back());
          Get.bottomSheet(
            Container(
              padding: EdgeInsets.symmetric(horizontal: 3.8.w, vertical: 1.h),
              width: 100.w,
              decoration: BoxDecoration(
                color: AppColors.WHITE,
                borderRadius: AppBorderRadius.inputRadius,
              ),
              child: Form(
                key: nameSurnameFormKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Direction.vertical.spacer(2.6),
                    // NAME TEXTFORMFIELD
                    CustomInputWithPrefixIcon(
                      hintText: AppStrings.nameHintText,
                      textEditingController: nameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppStrings.nameEmptyError;
                        }
                        return null;
                      },
                    ),
                    Direction.vertical.spacer(2.6),
                    // SURNAME TEXTFORMFIELD
                    CustomInputWithPrefixIcon(
                      hintText: AppStrings.surnameHintText,
                      textEditingController: surnameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppStrings.surnameEmptyError;
                        }
                        return null;
                      },
                    ),
                    Direction.vertical.spacer(2.6),
                    // LOGIN BUTTON
                    Obx(
                      () => CustomButton(
                        isLoading: isLoading.value,
                        bg: AppColors.BLUE_DIAMOND,
                        onTap: () {
                          if (nameSurnameFormKey.currentState!.validate()) {
                            handleUpdateNameSurname(
                                userId: resp.data["userId"]);
                          }
                        },
                        title: AppStrings.loginTitle,
                      ),
                    ),
                    Direction.vertical.spacer(2.6),
                  ],
                ),
              ),
            ),
          );
        } else if (resp.data["status"] == "success") {
          storage.write("uid", resp.data["userId"]);
          storage.write("uEmail", resp.data["userEmail"]);
          storage.write("uPassword", resp.data["userPassword"]);
          await OneSignal.login(resp.data["userId"]);
          Get.offNamed(Routes.NAVBAR);
        } else if (resp.data["status"] == "warning") {
          SnackbarType.error.CustomSnackbar(
              title: AppStrings.error, message: resp.data["message"]);
          await Future.delayed(const Duration(seconds: 2), () => Get.back());
        }
      });
    } catch (e) {
      isLoading.toggle();
      print("handleAppleSignIn error: $e");
    } finally {
      isLoading.toggle();
    }
  }

  Future<void> handleUpdateNameSurname({required String userId}) async {
    isLoading.toggle();
    final AppleSignInUpdateNameSurnameApi appleSignInUpdateNameSurnameApi =
        AppleSignInUpdateNameSurnameApi();
    final AppleSignInUpdateNameSurnameModel appleSignInUpdateNameSurnameModel =
        AppleSignInUpdateNameSurnameModel(
      secretKey: dotenv.env["SECRET_KEY"].toString(),
      userId: userId,
      ad: nameController.text.trim(),
      soyad: surnameController.text.trim(),
    );

    try {
      await appleSignInUpdateNameSurnameApi
          .handleUpdateNameSurname(
              data: appleSignInUpdateNameSurnameModel.toJson())
          .then((resp) async {
        if (resp.data["status"] == "success") {
          storage.write("uid", resp.data["userId"]);
          storage.write("uEmail", resp.data["userEmail"]);
          storage.write("uPassword", resp.data["userPassword"]);
          await OneSignal.login(resp.data["userId"]);
          Get.offNamed(Routes.NAVBAR);
        } else if (resp.data["status"] == "warning") {
          SnackbarType.error.CustomSnackbar(
              title: AppStrings.error, message: resp.data["message"]);
          await Future.delayed(const Duration(seconds: 2), () => Get.back());
        }
      });
    } catch (e) {
      isLoading.toggle();
      print("handleUpdateNameSurname error: $e");
    } finally {
      isLoading.toggle();
    }
  }

  @override
  void onClose() {
    super.onClose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    surnameController.dispose();
  }
}
