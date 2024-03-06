import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:sizer/sizer.dart';

class CustomVerificationCodeInput extends StatelessWidget {
  final TextEditingController verificationCodeController;

  const CustomVerificationCodeInput({
    super.key,
    required this.verificationCodeController,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: true,
      validator: (value) {
        if (value!.isEmpty) {
          return AppStrings.verificationCodeEmptyError;
        }
        return null;
      },
      controller: verificationCodeController,
      cursorColor: AppColors.BLACK,
      onTapOutside: (event) => FocusScope.of(Get.context!).unfocus(),
      style: Theme.of(Get.context!).textTheme.labelSmall?.copyWith(
            color: AppColors.HARD_COAL,
          ),
      maxLength: 6,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 3.w),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppBorderRadius.inputRadius,
          borderSide: BorderSide(
            width: .2.w,
            color: AppColors.ASHENVALE_NIGHTS.withOpacity(.5),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppBorderRadius.inputRadius,
          borderSide: BorderSide(
            width: .2.w,
            color: AppColors.ASHENVALE_NIGHTS.withOpacity(.5),
          ),
        ),
      ),
    );
  }
}
