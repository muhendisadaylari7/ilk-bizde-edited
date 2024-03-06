// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/widgets/index.dart';
import 'package:sizer/sizer.dart';

class CustomSortAdsBottomSheet extends StatelessWidget {
  final dynamic controller;
  const CustomSortAdsBottomSheet({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      decoration: BoxDecoration(
        color: Get.isDarkMode ? AppColors.SOOTY : AppColors.WHITE,
        borderRadius: AppBorderRadius.inputRadius,
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 3.w,
              vertical: 1.h,
            ),
            decoration: BoxDecoration(
              color: Get.isDarkMode
                  ? AppColors.BLACK_WASH
                  : AppColors.ZHEN_ZHU_BAI_PEARL,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(5.7.sp),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomIconButton(
                  onTap: () => Get.back(),
                  child: Icon(
                    Icons.close,
                    color: Get.isDarkMode ? AppColors.WHITE : AppColors.BLACK,
                  ),
                ),
                Text(
                  AppStrings.sort,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Get.isDarkMode ? null : AppColors.CORBEAU,
                        fontFamily: AppFonts.regular,
                      ),
                ),
                Bounceable(
                  onTap: () => controller.handleSort(),
                  child: Text(
                    AppStrings.select,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Get.isDarkMode
                              ? null
                              : AppColors.ASHENVALE_NIGHTS,
                        ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              alignment: Alignment.center,
              child: ListView.builder(
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.sortItems.length,
                itemBuilder: (context, index) {
                  return Obx(
                    () => Bounceable(
                      onTap: () {
                        controller.selectedIndex.value = index;
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 1.h),
                        decoration: BoxDecoration(
                          color: controller.selectedIndex.value == index
                              ? Get.isDarkMode
                                  ? AppColors.BRANDEIS_BLUE.withOpacity(.1)
                                  : AppColors.ASHENVALE_NIGHTS.withOpacity(.1)
                              : Colors.transparent,
                          borderRadius: AppBorderRadius.inputRadius,
                        ),
                        child: Text(
                          controller.sortItems[index],
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(
                                color: controller.selectedIndex.value == index
                                    ? Get.isDarkMode
                                        ? AppColors.BRANDEIS_BLUE
                                        : AppColors.ASHENVALE_NIGHTS
                                    : Get.isDarkMode
                                        ? null
                                        : AppColors.CORBEAU,
                                fontFamily: AppFonts.light,
                              ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
