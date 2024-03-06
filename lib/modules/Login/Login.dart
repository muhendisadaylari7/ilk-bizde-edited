// ignore_for_file: file_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:ilkbizde/controllers/NetworkController.dart';
import 'package:ilkbizde/modules/Login/LoginController.dart';
import 'package:ilkbizde/routes/app_pages.dart';
import 'package:ilkbizde/shared/enum/images.dart';
import 'package:ilkbizde/shared/widgets/index.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:sizer/sizer.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.WHITE,
        foregroundColor: AppColors.BLACK,
      ),
      body: GetBuilder<NetworkController>(builder: (networkController) {
        if (networkController.connectionType.value == 0) {
          return const CustomNoInternetWidget();
        }
        return SafeArea(
          child: Center(
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Container(
                padding: AppPaddings.generalPadding,
                alignment: Alignment.center,
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // LOGO
                      SizedBox(
                        width: 9.6.h,
                        height: 9.6.h,
                        child: Images.appLogo.png,
                      ),
                      Direction.vertical.spacer(8.6),
                      // TITLE
                      const CustomSemiBoldLargeText(
                        title: AppStrings.loginTitle,
                      ),
                      // SUBTITLE
                      const CustomRegularSmallText(
                        title: AppStrings.loginSubtitle,
                      ),
                      Direction.vertical.spacer(4.7),
                      // EMAIL INPUT
                      CustomInputWithPrefixIcon(
                        validator: (value) {
                          if (value == null) return null;
                          if (value.isEmpty) {
                            return AppStrings.emailEmptyError;
                          }
                          return null;
                        },
                        hintText: AppStrings.emailHintText,
                        image: Images.email,
                        textEditingController: controller.emailController,
                      ),
                      Direction.vertical.spacer(2.6),
                      // PASSWORD INPUT
                      CustomInputWithPrefixIcon(
                        validator: (value) {
                          if (value == null) return null;
                          if (value.isEmpty) {
                            return AppStrings.passwordValidatorError;
                          }
                          return null;
                        },
                        obscureText: true,
                        hintText: AppStrings.passwordHintText,
                        image: Images.lock,
                        textInputAction: TextInputAction.done,
                        textEditingController: controller.passwordController,
                        onFieldSubmitted: (value) {
                          if (controller.formKey.currentState!.validate()) {
                            controller.handleLogin();
                          }
                        },
                      ),
                      Direction.vertical.spacer(2.6),
                      // FORGOT PASSWORD BUTTON
                      CustomTextButton(
                        title: AppStrings.forgotPasswordBtnText,
                        onTap: () => Get.toNamed(Routes.FORGOTPASSWORD),
                      ),
                      Direction.vertical.spacer(2.6),
                      // LOGIN BUTTON
                      Obx(
                        () => CustomButton(
                          isLoading: controller.isLoading.value,
                          bg: AppColors.BLUE_DIAMOND,
                          onTap: () {
                            if (controller.formKey.currentState!.validate()) {
                              controller.handleLogin();
                            }
                          },
                          title: AppStrings.loginTitle,
                        ),
                      ),
                      Direction.vertical.spacer(5.2),
                      // DONT HAVE ACCOUNT BUTTON
                      CustomTextRich(
                        text1: AppStrings.dontHaveAccountBtnText,
                        text2: AppStrings.signupTitle,
                        text2OnTap: () => Get.toNamed(Routes.SIGNUP),
                      ),
                      Direction.vertical.spacer(2.6),
                      Obx(
                        () => !Platform.isIOS
                            ? CustomOAUTHButton(
                                bg: AppColors.WHITE,
                                isLoading: controller.isLoading.value,
                                onTap: () => controller.handleGoogleSignIn(),
                                icon: SizedBox(
                                  width: 2.8.h,
                                  height: 2.8.h,
                                  child: Images.google.pngWithScale,
                                ),
                                text: "Google ile Giriş Yap",
                                textColor: AppColors.BLACK,
                              )
                            : Row(
                                children: [
                                  // LOGIN WITH APPLE BUTTON
                                  Expanded(
                                    child: CustomOAUTHButton(
                                      bg: AppColors.WHITE,
                                      isLoading: controller.isLoading.value,
                                      onTap: () =>
                                          controller.handleAppleSignIn(),
                                      icon: const Icon(
                                        Icons.apple_outlined,
                                        color: AppColors.BLACK,
                                      ),
                                      text: "Apple ile\nGiriş Yap",
                                      textColor: AppColors.BLACK,
                                    ),
                                  ),
                                  Direction.horizontal.spacer(2),
                                  // LOGIN WITH GOOGLE BUTTON
                                  Expanded(
                                    child: CustomOAUTHButton(
                                      bg: AppColors.WHITE,
                                      isLoading: controller.isLoading.value,
                                      onTap: () =>
                                          controller.handleGoogleSignIn(),
                                      icon: SizedBox(
                                        width: 2.8.h,
                                        height: 2.8.h,
                                        child: Images.google.pngWithScale,
                                      ),
                                      text: "Google ile\nGiriş Yap",
                                      textColor: AppColors.BLACK,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                      Direction.vertical.spacer(1.6),
                      // LOGIN WITH PHONE NUMBER BUTTON
                      CustomOAUTHButton(
                        bg: AppColors.ASHENVALE_NIGHTS,
                        isLoading: controller.isLoading.value,
                        onTap: () => Get.toNamed(Routes.LOGINWITHPHONENUMBER),
                        icon: const Icon(
                          Icons.phone_outlined,
                          color: AppColors.WHITE,
                        ),
                        text: "Telefon Numarası ile Giriş Yap",
                        textColor: AppColors.WHITE,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

class CustomOAUTHButton extends StatelessWidget {
  final bool isLoading;
  final void Function()? onTap;
  final Color bg;
  final Widget icon;
  final String text;
  final Color textColor;
  const CustomOAUTHButton({
    super.key,
    required this.isLoading,
    required this.onTap,
    required this.bg,
    required this.icon,
    required this.text,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: isLoading ? null : onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
        decoration: BoxDecoration(
          color: bg,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 0),
              blurRadius: 15,
              spreadRadius: -5,
              color: AppColors.BLACK.withOpacity(.3),
            )
          ],
          borderRadius: AppBorderRadius.inputRadius,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            Direction.horizontal.spacer(2),
            Expanded(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: textColor,
                      fontFamily: AppFonts.semiBold,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
