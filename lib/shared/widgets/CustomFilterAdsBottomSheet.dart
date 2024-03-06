// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:ilkbizde/modules/CategoryResultPage/CategoryResultPageController.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/widgets/index.dart';
import 'package:sizer/sizer.dart';

class CustomFilterAdsBottomSheet extends StatelessWidget {
  final CategoryResultPageController controller;
  const CustomFilterAdsBottomSheet({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomFilterBottomSheetAppBar(
        clearFunction: () => controller.clearFilter(),
      ),
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: controller.filterItems.length,
              separatorBuilder: (context, index) => const CustomSeperatorWidget(
                color: AppColors.ZHEN_ZHU_BAI_PEARL,
              ),
              itemBuilder: (context, index) {
                controller.checkboxSelectedValueRandom(index);
                return Bounceable(
                  onTap: () {
                    if (index == 2) {
                      controller.getCities();
                    }
                    controller.filterItemOnTap(index, context);
                  },
                  child: Container(
                    color: Colors.transparent,
                    padding: AppPaddings.generalPadding.copyWith(
                      top: 1.h,
                      bottom: 1.h,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          controller.filterItems[index]["data"].filterName,
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(
                                color:
                                    Get.isDarkMode ? null : AppColors.CORBEAU,
                              ),
                        ),
                        const Icon(
                          Icons.arrow_forward_outlined,
                          color: AppColors.CYAN_SKY,
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Bounceable(
            onTap: () => controller.handleFilter(),
            child: Container(
              width: 100.w,
              height: 6.h,
              margin: EdgeInsets.only(
                left: 4.w,
                right: 4.w,
                bottom: 4.h,
                top: 1.h,
              ),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Get.isDarkMode
                    ? AppColors.BRANDEIS_BLUE.withOpacity(.1)
                    : AppColors.ASHENVALE_NIGHTS.withOpacity(.1),
                borderRadius: BorderRadius.circular(12.sp),
              ),
              child: Text(
                AppStrings.listAds,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Get.isDarkMode
                          ? AppColors.BRANDEIS_BLUE
                          : AppColors.ASHENVALE_NIGHTS,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
