// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilkbizde/modules/CategoryResultPage/index.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/widgets/index.dart';
import 'package:sizer/sizer.dart';

class CustomFilterTypeSelectWidget extends StatelessWidget {
  final String title;
  final CategoryResultPageController categoryResultPageController;
  final int filterItemIndex;
  final void Function() saveOnTap;
  const CustomFilterTypeSelectWidget({
    super.key,
    required this.title,
    required this.categoryResultPageController,
    required this.filterItemIndex,
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
              Direction.vertical.spacer(4),
              Obx(
                () => CustomDropdownFieldWithList(
                  value:
                      categoryResultPageController.selectedDropdownValue.value,
                  items: categoryResultPageController
                      .filterItems[filterItemIndex]["data"].filterChoises
                      .split("||")
                      .map<DropdownMenuItem<String>>(
                          (String value) => DropdownMenuItem(
                                value: value,
                                onTap: () => categoryResultPageController
                                    .selectedDropdownValue.value = value,
                                child: Text(value),
                              ))
                      .toList(),
                ),
              ),
              Direction.vertical.spacer(4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomDialogButton(
                    color: AppColors.WHITE,
                    textColor: AppColors.ASHENVALE_NIGHTS,
                    onTap: () => Get.back(),
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
