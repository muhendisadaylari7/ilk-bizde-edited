// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:sizer/sizer.dart';

class CustomChangePasswordInput extends StatelessWidget {
  final bool obscureText;
  final Widget suffixIcon;
  final String? Function(String?)? validator;
  final TextEditingController textEditingController;
  const CustomChangePasswordInput({
    super.key,
    required this.obscureText,
    required this.suffixIcon,
    this.validator,
    required this.textEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      validator: validator,
      controller: textEditingController,
      cursorColor: AppColors.BLACK,
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: AppColors.HARD_COAL,
          ),
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
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
