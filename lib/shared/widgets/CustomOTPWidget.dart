// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/widgets/index.dart';
import 'package:sizer/sizer.dart';
import 'package:sms_autofill/sms_autofill.dart';

class CustomOTPWidget extends StatelessWidget {
  final String phoneNumber;
  final TextEditingController pinCodeController;
  final void Function()? retrySend;
  final void Function()? confirm;
  final bool isLoading;
  const CustomOTPWidget({
    super.key,
    required this.phoneNumber,
    this.retrySend,
    this.confirm,
    required this.isLoading,
    required this.pinCodeController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPaddings.generalPadding,
      child: Column(
        children: [
          Direction.vertical.spacer(4.6),
          Text(
            AppStrings.loginWithPhoneNumberTitle,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppColors.ASHENVALE_NIGHTS,
                  fontFamily: AppFonts.bold,
                ),
          ),
          Direction.vertical.spacer(2.6),
          Text(
            AppStrings.loginWithPhoneNumberSubtitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColors.DUGONG,
                  fontSize: 9.5.sp,
                ),
          ),
          Direction.vertical.spacer(1),
          Text(
            phoneNumber,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColors.BLACK,
                  fontSize: 9.5.sp,
                  fontFamily: AppFonts.bold,
                ),
          ),
          Direction.vertical.spacer(2.6),
          PinFieldAutoFill(
            codeLength: 6,
            autoFocus: true,
            controller: pinCodeController,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            cursor: Cursor.disabled(),
            enableInteractiveSelection: false,
            currentCode: pinCodeController.text,
            onCodeChanged: (p0) {
              pinCodeController.text = p0!;
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
          Direction.vertical.spacer(2.6),
          CustomTextRich(
            text1: AppStrings.otpText1,
            text2: AppStrings.otpText2,
            text2Color: AppColors.FENNEL_FIESTA,
            text2OnTap: retrySend,
          ),
          Direction.vertical.spacer(2.6),
          CustomButton(
            title: AppStrings.confirm,
            bg: AppColors.ASHENVALE_NIGHTS,
            isLoading: isLoading,
            onTap: confirm,
          )
        ],
      ),
    );
  }
}
