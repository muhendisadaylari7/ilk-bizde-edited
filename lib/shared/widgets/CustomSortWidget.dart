// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/widgets/index.dart';
import 'package:sizer/sizer.dart';

class CustomSortWidget extends StatelessWidget {
  final dynamic controller;
  final String title;
  const CustomSortWidget({
    super.key,
    required this.controller,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: () {
        controller.selectedIndex.value = controller.selectedSortItem.value != 0
            ? controller.selectedSortItem.value - 1
            : 0;
        Get.bottomSheet(
          CustomSortAdsBottomSheet(
            controller: controller,
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 3.w,
          vertical: 1.h,
        ),
        decoration: BoxDecoration(
          color: Get.isDarkMode ? AppColors.BLACK_WASH : AppColors.WHITE,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 2),
              blurRadius: 6,
              spreadRadius: 0,
              color: AppColors.BLACK.withOpacity(.25),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.SHY_MOMENT,
                  ),
            ),
            Icon(
              Icons.swap_vert,
              color: AppColors.SHY_MOMENT,
              size: 14.sp,
            )
          ],
        ),
      ),
    );
  }
}
