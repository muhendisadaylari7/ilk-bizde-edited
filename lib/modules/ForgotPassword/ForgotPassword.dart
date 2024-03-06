// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilkbizde/controllers/NetworkController.dart';
import 'package:ilkbizde/modules/ForgotPassword/ForgotPasswordController.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/enum/images.dart';
import 'package:ilkbizde/shared/widgets/index.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final ForgotPasswordController controller =
      Get.put(ForgotPasswordController());

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
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Container(
              alignment: Alignment.center,
              padding: AppPaddings.generalPadding,
              child: Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    Images.forgotPassword.pngWithScale,
                    Direction.vertical.spacer(2.6),
                    const CustomSemiBoldLargeText(
                      title: AppStrings.forgotPasswordBtnText,
                    ),
                    const CustomRegularSmallText(
                      title: AppStrings.signupSubtitle,
                    ),
                    Direction.vertical.spacer(2.6),
                    CustomInputWithPrefixIcon(
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return AppStrings.emailEmptyError;
                        } else if (!controller.emailRegex.hasMatch(p0)) {
                          return AppStrings.emailRegexError;
                        }
                        return null;
                      },
                      hintText: AppStrings.emailHintText,
                      image: Images.email,
                      textEditingController: controller.emailController,
                    ),
                    Direction.vertical.spacer(2.6),
                    Obx(
                      () => CustomButton(
                        isLoading: controller.isLoading.value,
                        hasIcon: true,
                        icon: Images.send.pngWithScale,
                        title: AppStrings.forgotPasswordResetPasswordBtnText,
                        bg: AppColors.HORNET_STING,
                        onTap: () {
                          if (controller.formKey.currentState!.validate()) {
                            controller.handleForgotPassword();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
