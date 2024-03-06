// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilkbizde/data/model/CityModel.dart';
import 'package:ilkbizde/data/model/DistrictModel.dart';
import 'package:ilkbizde/data/model/NeighborhoodResponseModel.dart';
import 'package:ilkbizde/modules/CategoryResultPage/CategoryResultPageController.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/widgets/index.dart';
import 'package:sizer/sizer.dart';

class CustomFilterTypeAdressSelectWidget extends StatelessWidget {
  final String title;
  final CategoryResultPageController controller;
  final int filterItemIndex;
  const CustomFilterTypeAdressSelectWidget({
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
                  value: controller.selectedCity.value,
                  items: controller.cities
                      .map<DropdownMenuItem<String>>(
                          (CityModel cityModel) => DropdownMenuItem(
                                value: cityModel.name,
                                onTap: () async {
                                  controller.filterItems[filterItemIndex]
                                      ["selectedValue"] = "";
                                  controller.selectedCity.value =
                                      cityModel.name;

                                  await controller.getDistricts(
                                    cityId: cityModel.id,
                                  );
                                },
                                child: Text(cityModel.name),
                              ))
                      .toList(),
                ),
              ),
              Direction.vertical.spacer(1),
              Obx(
                () => controller.districts.isEmpty
                    ? const SizedBox.shrink()
                    : CustomDropdownFieldWithList(
                        value: controller.selectedDistrict.value,
                        items: controller.districts
                            .map<DropdownMenuItem<String>>(
                                (DistrictModel districtModel) =>
                                    DropdownMenuItem(
                                      value: districtModel.name,
                                      onTap: () async {
                                        controller.selectedDistrict.value =
                                            districtModel.name;
                                        await controller.getNeighborhood(
                                          districtId: districtModel.id,
                                        );
                                        controller.selectedNeighborhood.value =
                                            controller.neighborhoods.first.name;
                                      },
                                      child: Text(districtModel.name),
                                    ))
                            .toList(),
                      ),
              ),
              Direction.vertical.spacer(1),
              Obx(
                () => controller.neighborhoods.isEmpty
                    ? const SizedBox.shrink()
                    : CustomDropdownFieldWithList(
                        value: controller.selectedNeighborhood.value,
                        items: controller.neighborhoods
                            .map<DropdownMenuItem<String>>(
                              (NeighborhoodResponseModel
                                      neighborhoodResponseModel) =>
                                  DropdownMenuItem(
                                value: neighborhoodResponseModel.name,
                                onTap: () {
                                  controller.selectedNeighborhood.value =
                                      neighborhoodResponseModel.name;
                                },
                                child: Text(
                                  neighborhoodResponseModel.name,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            )
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
                    onTap: () {
                      Get.back();
                      controller.filterItems[filterItemIndex]["selectedValue"] =
                          "${controller.selectedCity.value}-${controller.selectedDistrict.value}-${controller.selectedNeighborhood.value}";
                    },
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
