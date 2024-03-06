// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:ilkbizde/controllers/NetworkController.dart';
import 'package:ilkbizde/modules/ChangePassword/ChangePasswordController.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/widgets/index.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final ChangePasswordController controller =
      Get.put(ChangePasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomMyAccountItemAppBar(title: AppStrings.changePassword),
      body: GetBuilder<NetworkController>(builder: (networkController) {
        if (networkController.connectionType.value == 0) {
          return const CustomNoInternetWidget();
        }
        return SingleChildScrollView(
          child: Padding(
            padding: AppPaddings.generalPadding,
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Direction.vertical.spacer(4),
                  Center(
                    child: Text(
                      AppStrings.changePasswordTitle,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: AppColors.SILVER,
                            fontFamily: AppFonts.regular,
                          ),
                    ),
                  ),
                  Direction.vertical.spacer(2),
                  Form(
                    key: controller.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomInputLabel(
                            text: AppStrings.currentPassword),
                        Direction.vertical.spacer(.3),
                        CustomChangePasswordInput(
                          textEditingController:
                              controller.currentPasswordController,
                          obscureText: !controller.isVisible.value,
                          suffixIcon: Bounceable(
                            onTap: () {
                              controller.isVisible.toggle();
                            },
                            child: controller.isVisible.value
                                ? const Icon(Icons.visibility_off_outlined)
                                : const Icon(Icons.visibility_outlined),
                          ),
                        ),
                        Direction.vertical.spacer(2),
                        const CustomInputLabel(text: AppStrings.newPassword),
                        Direction.vertical.spacer(.3),
                        CustomChangePasswordInput(
                          textEditingController:
                              controller.newPasswordController,
                          validator: (p0) {
                            if (p0!.isEmpty) {
                              return AppStrings.newPasswordEmptyError;
                            } else if (p0.length < 6) {
                              return AppStrings.newPasswordLengthError;
                            }
                            return null;
                          },
                          obscureText: !controller.isVisible.value,
                          suffixIcon: const SizedBox.shrink(),
                        ),
                        Direction.vertical.spacer(2),
                        const CustomInputLabel(
                            text: AppStrings.newPasswordAgain),
                        Direction.vertical.spacer(.3),
                        CustomChangePasswordInput(
                          validator: (p0) {
                            if (p0!.isEmpty) {
                              return AppStrings.newPasswordAgainEmptyError;
                            } else if (p0 !=
                                controller.newPasswordController.text) {
                              return AppStrings.newPasswordAgainNoMatchError;
                            }
                            return null;
                          },
                          textEditingController:
                              controller.newPasswordAgainController,
                          obscureText: !controller.isVisible.value,
                          suffixIcon: const SizedBox.shrink(),
                        ),
                      ],
                    ),
                  ),
                  Direction.vertical.spacer(4),
                  Text(
                    AppStrings.passwordRequirementsTitle,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppColors.VALHALLA,
                          fontFamily: AppFonts.semiBold,
                        ),
                  ),
                  Direction.vertical.spacer(.5),
                  Text(
                    AppStrings.passwordRequirementsSubtitle,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppColors.WHARF_VIEW,
                        ),
                  ),
                  Direction.vertical.spacer(.5),
                  const CustomPasswordRequirementsItem(
                    text: AppStrings.passwordRequirements1,
                  ),
                  Direction.vertical.spacer(4),
                  Obx(
                    () => Center(
                      child: CustomButton(
                        isLoading: controller.isLoading.value,
                        title: AppStrings.save,
                        bg: AppColors.ALOHA,
                        onTap: () {
                          if (controller.formKey.currentState!.validate()) {
                            controller.handleChangePassword();
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
