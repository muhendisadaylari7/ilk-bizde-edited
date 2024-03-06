import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ilkbizde/modules/PersonalInformation/index.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/widgets/index.dart';
import 'package:sizer/sizer.dart';
import 'package:sms_autofill/sms_autofill.dart';

class CustomVerificationCodeDialog extends StatelessWidget {
  final PersonalInformationController personalInformationController;
  const CustomVerificationCodeDialog(
      {super.key, required this.personalInformationController});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 75.w,
        child: Material(
          color: AppColors.WHITE,
          borderRadius: AppBorderRadius.inputRadius,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Direction.vertical.spacer(2),
                CustomInputLabel(
                  text: AppStrings.verificationCodeLabel,
                  textColor: AppColors.BLACK,
                ),
                Direction.vertical.spacer(2),
                PinFieldAutoFill(
                  codeLength: 6,
                  autoFocus: true,
                  controller: personalInformationController.pinCodeController,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  cursor: Cursor.disabled(),
                  enableInteractiveSelection: false,
                  currentCode:
                      personalInformationController.pinCodeController.text,
                  onCodeChanged: (p0) {
                    personalInformationController.pinCodeController.text = p0!;
                  },
                  decoration: CirclePinDecoration(
                    bgColorBuilder: PinListenColorBuilder(
                      Colors.transparent,
                      AppColors.IMAGINATION,
                    ),
                    strokeColorBuilder: PinListenColorBuilder(
                      AppColors.ASHENVALE_NIGHTS,
                      AppColors.IMAGINATION,
                    ),
                  ),
                ),
                Direction.vertical.spacer(3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomDialogButton(
                      onTap: () {
                        personalInformationController.pinCodeController.clear();
                        Get.back();
                      },
                      color: AppColors.WHITE,
                      text: AppStrings.cancel,
                      textColor: AppColors.ASHENVALE_NIGHTS,
                    ),
                    Obx(
                      () => CustomDialogButton(
                        isLoading: personalInformationController
                            .isSavePhoneNumberLoading.value,
                        onTap: personalInformationController
                                .isSavePhoneNumberLoading.value
                            ? null
                            : () =>
                                personalInformationController.savePhoneNumber(),
                        color: AppColors.ASHENVALE_NIGHTS,
                        text: "Onayla",
                        textColor: AppColors.WHITE,
                      ),
                    ),
                  ],
                ),
                Direction.vertical.spacer(2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
