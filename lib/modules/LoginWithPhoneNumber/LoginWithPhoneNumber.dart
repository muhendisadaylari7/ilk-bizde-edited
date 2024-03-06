// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilkbizde/controllers/NetworkController.dart';
import 'package:ilkbizde/modules/LoginWithPhoneNumber/LoginWithPhoneNumberController.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/enum/images.dart';
import 'package:ilkbizde/shared/widgets/index.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class LoginWithPhoneNumber extends StatefulWidget {
  const LoginWithPhoneNumber({super.key});

  @override
  State<LoginWithPhoneNumber> createState() => _LoginWithPhoneNumberState();
}

class _LoginWithPhoneNumberState extends State<LoginWithPhoneNumber> {
  final LoginWithPhoneNumberController controller =
      Get.put(LoginWithPhoneNumberController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.WHITE,
        foregroundColor: AppColors.BLACK,
        title: Container(
          decoration: BoxDecoration(
            borderRadius: AppBorderRadius.inputRadius,
            color: AppColors.IMAGINATION,
          ),
          child: SmoothPageIndicator(
              controller: controller.pageController, // PageController
              count: 2,
              effect: ExpandingDotsEffect(
                dotHeight: 1.5.h,
                activeDotColor: AppColors.ASHENVALE_NIGHTS,
                dotColor: AppColors.IMAGINATION,
              ), // your preferred effect
              onDotClicked: (index) {}),
        ),
      ),
      body: GetBuilder<NetworkController>(builder: (networkController) {
        if (networkController.connectionType.value == 0) {
          return const CustomNoInternetWidget();
        }
        return SafeArea(
          child: PageView.builder(
            controller: controller.pageController,
            scrollDirection: Axis.horizontal,
            itemCount: 2,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return index == 0
                  ? SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      child: Obx(
                        () => CustomWithPhoneNumber(
                          textEditingController:
                              controller.phoneNumberController,
                          image: Images.loginWithPhoneNumber,
                          formKey: controller.formKey,
                          title: AppStrings.loginTitle,
                          buttonTitle: AppStrings.loginTitle,
                          buttonColor: AppColors.FENNEL_FIESTA,
                          isLoading: controller.isLoading.value,
                          onTap: controller.isLoading.value
                              ? null
                              : () async {
                                  if (controller.formKey.currentState!
                                      .validate()) {
                                    await controller.sendCode();
                                  }
                                },
                        ),
                      ),
                    )
                  : Obx(
                      () => CustomOTPWidget(
                        pinCodeController: controller.pinCodeController,
                        phoneNumber: controller.phoneNumber.value,
                        isLoading: controller.isLoading.value,
                        retrySend: controller.isLoading.value
                            ? null
                            : () => controller.sendCode(),
                        confirm: controller.isLoading.value
                            ? null
                            : () => controller.loginWithPhoneNumber(),
                      ),
                    );
            },
          ),
        );
      }),
    );
  }
}
