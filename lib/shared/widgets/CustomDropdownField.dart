// ignore_for_file: must_be_immutable, file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:sizer/sizer.dart';

class CustomDropdownFormField extends StatelessWidget {
  RxString accountType;
  final String firstDropdownMenuItem;
  final String secondDropdownMenuItem;
  CustomDropdownFormField({
    super.key,
    required this.accountType,
    required this.firstDropdownMenuItem,
    required this.secondDropdownMenuItem,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => DropdownButtonFormField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 4.w),
        ),
        borderRadius: AppBorderRadius.inputRadius,
        dropdownColor: AppColors.WHITE,
        value: accountType.value,
        items: [
          CustomDropdownMenuItem(firstDropdownMenuItem, context),
          CustomDropdownMenuItem(secondDropdownMenuItem, context),
        ],
        onChanged: (value) {
          if (value == null) return;
          accountType.value = value;
        },
        style: Theme.of(context)
            .textTheme
            .labelMedium
            ?.copyWith(color: AppColors.OBSIDIAN_SHARD),
      ),
    );
  }

  DropdownMenuItem<String> CustomDropdownMenuItem(
      String text, BuildContext context) {
    return DropdownMenuItem(
      value: text,
      child: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .labelMedium
            ?.copyWith(color: AppColors.OBSIDIAN_SHARD),
      ),
    );
  }
}
