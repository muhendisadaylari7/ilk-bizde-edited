// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:sizer/sizer.dart';

class CustomDropdownFieldWithList extends StatelessWidget {
  final List<DropdownMenuItem<String>>? items;
  String? value;
  final String? Function(String?)? validator;
  CustomDropdownFieldWithList({
    super.key,
    this.items,
    this.value,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      validator: validator,
      isExpanded: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 4.w),
      ),
      borderRadius: AppBorderRadius.inputRadius,
      dropdownColor: Get.isDarkMode ? null : AppColors.WHITE,
      value: value,
      items: items,
      onChanged: (p0) {
        if (p0 == null) return;
        value = p0;
      },
      style: Theme.of(context)
          .textTheme
          .labelMedium
          ?.copyWith(color: Get.isDarkMode ? null : AppColors.OBSIDIAN_SHARD),
    );
  }
}
