// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:ilkbizde/modules/AdvertisementDetail/AdvertisementDetailController.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:sizer/sizer.dart';

class CustomTabWidget extends StatelessWidget {
  final void Function() onTap;
  final int tabIndex;
  final String title;
  CustomTabWidget({
    super.key,
    required this.onTap,
    required this.tabIndex,
    required this.title,
  });

  final AdvertisementDetailController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Bounceable(
        onTap: () {
          onTap();
          controller.selectedTab.value = controller.tabController.index;
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 1.w),
          padding: EdgeInsets.symmetric(vertical: 1.h),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: controller.selectedTab.value == tabIndex
                ? AppColors.CHEERFUL_YELLOW
                : Get.isDarkMode
                    ? AppColors.BLACK_WASH
                    : AppColors.WHITE,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(3)),
            border: Border(
              left: BorderSide(
                color: controller.selectedTab.value == tabIndex
                    ? AppColors.BANANA_CLAN
                    : AppColors.STELLAR_BLUE.withOpacity(.4),
                width: 1,
              ),
              right: BorderSide(
                color: controller.selectedTab.value == tabIndex
                    ? AppColors.BANANA_CLAN
                    : AppColors.STELLAR_BLUE.withOpacity(.4),
                width: 1,
              ),
              top: BorderSide(
                color: controller.selectedTab.value == tabIndex
                    ? AppColors.BANANA_CLAN
                    : AppColors.STELLAR_BLUE.withOpacity(.4),
                width: 1,
              ),
              bottom: BorderSide(
                color: controller.selectedTab.value == tabIndex
                    ? AppColors.BANANA_CLAN
                    : AppColors.STELLAR_BLUE.withOpacity(.4),
                width: 0,
              ),
            ),
          ),
          child: Text(
            title,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  fontFamily: AppFonts.regular,
                  color: Get.isDarkMode ? AppColors.WHITE : AppColors.BLACK,
                ),
          ),
        ),
      ),
    );
  }
}
