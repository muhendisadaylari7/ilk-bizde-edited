// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilkbizde/modules/CategoryResultPage/index.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/widgets/index.dart';
import 'package:sizer/sizer.dart';

class CustomFilterTypeCheckboxWidget extends StatelessWidget {
  final CategoryResultPageController controller;
  final String title;
  final int filterItemIndex;
  const CustomFilterTypeCheckboxWidget({
    super.key,
    required this.title,
    required this.controller,
    required this.filterItemIndex,
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
          child: Obx(
            () => Column(
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
                Container(
                  constraints: BoxConstraints(
                    maxHeight: 40.h,
                    minHeight: 20.h,
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: controller
                        .filterItems[filterItemIndex]["data"].filterChoises
                        .split("||")
                        .length,
                    itemBuilder: (context, index) {
                      return Obx(
                        () => CheckboxListTile(
                          activeColor: AppColors.ASHENVALE_NIGHTS,
                          checkColor: AppColors.WHITE,
                          value: controller.selectedCheckboxValueList[index] ==
                                  "true"
                              ? true
                              : false,
                          onChanged: (bool? value) async {
                            controller.selectedCheckboxValueList
                                .removeAt(index);
                            controller.selectedCheckboxValueList
                                .insert(index, value.toString());
                          },
                          title: Text(
                            controller.filterItems[filterItemIndex]["data"]
                                .filterChoises
                                .split("||")[index],
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Direction.vertical.spacer(1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomDialogButton(
                      color: AppColors.WHITE,
                      textColor: AppColors.ASHENVALE_NIGHTS,
                      onTap: () {
                        Get.back();
                        controller.filterItems[filterItemIndex]
                            ["selectedValue"] = "";
                        controller.checkboxSelectedValueRandom(filterItemIndex);
                      },
                      text: AppStrings.cancel,
                    ),
                    Direction.horizontal.spacer(2),
                    CustomDialogButton(
                      color: AppColors.ASHENVALE_NIGHTS,
                      textColor: AppColors.WHITE,
                      onTap: () {
                        Get.back();
                        controller.filterItems[filterItemIndex]
                            ["selectedValue"] = "";
                        controller.filterItems[filterItemIndex]
                                ["selectedValue"] =
                            controller.selectedCheckboxValueList.join("-");
                        controller.filterItems.refresh();
                      },
                      text: AppStrings.save.toUpperCase(),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
