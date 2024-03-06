// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/widgets/index.dart';
import 'package:sizer/sizer.dart';

class CustomFilterTypeTextWidget extends StatelessWidget {
  final String title;
  final TextEditingController atLeastController;
  final TextEditingController atMostController;
  final bool isNumberType;
  final void Function() cancelOnTap;
  final void Function() saveOnTap;
  const CustomFilterTypeTextWidget({
    super.key,
    required this.title,
    required this.atLeastController,
    required this.atMostController,
    this.isNumberType = false,
    required this.cancelOnTap,
    required this.saveOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        borderRadius: AppBorderRadius.inputRadius,
        color: AppColors.WHITE,
        child: Container(
          width: 70.w,
          padding: EdgeInsets.symmetric(
            horizontal: 5.w,
            vertical: 2.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .labelSmall
                    ?.copyWith(fontSize: 13.sp),
              ),
              Direction.vertical.spacer(1),
              const CustomInputLabel(text: "En az"),
              Direction.vertical.spacer(1),
              CustomPersonalInfoInput(
                hintText: "Bir değer giriniz lütfen",
                isNumberType: isNumberType,
                textEditingController: atLeastController,
              ),
              Direction.vertical.spacer(1),
              const CustomInputLabel(text: "En çok"),
              Direction.vertical.spacer(1),
              CustomPersonalInfoInput(
                isNumberType: isNumberType,
                hintText: "Bir değer giriniz lütfen",
                textEditingController: atMostController,
              ),
              Direction.vertical.spacer(4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomDialogButton(
                    color: AppColors.WHITE,
                    textColor: AppColors.ASHENVALE_NIGHTS,
                    onTap: cancelOnTap,
                    text: AppStrings.cancel,
                  ),
                  Direction.horizontal.spacer(2),
                  CustomDialogButton(
                    color: AppColors.ASHENVALE_NIGHTS,
                    textColor: AppColors.WHITE,
                    onTap: saveOnTap,
                    text: AppStrings.save.toUpperCase(),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
