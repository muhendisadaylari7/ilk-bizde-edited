// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:sizer/sizer.dart';

class CustomBlogAndNewsSearchInput extends StatelessWidget {
  final dynamic controller;
  final String hintText;
  const CustomBlogAndNewsSearchInput({
    super.key,
    required this.controller,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      controller: controller.searchController,
      onChanged: (value) {
        controller.searchController.addListener(() async {
          controller.searchQuery.value = controller.searchController.text;
          await Future.delayed(
            const Duration(milliseconds: 700),
            () => controller.search(),
          );
        });
      },
      cursorColor: AppColors.BLACK,
      style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: Get.isDarkMode ? null : AppColors.OBSIDIAN_SHARD,
          ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
        fillColor: Get.isDarkMode ? null : AppColors.CASCADING_WHITE,
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: AppColors.NOGHREI_SILVER,
              fontFamily: AppFonts.medium,
            ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.sp),
          borderSide: const BorderSide(
            color: AppColors.UNICORN_SILVER,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.sp),
          borderSide: const BorderSide(
            color: AppColors.UNICORN_SILVER,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.sp),
          borderSide: const BorderSide(
            color: AppColors.UNICORN_SILVER,
            width: 1,
          ),
        ),
      ),
    );
  }
}
