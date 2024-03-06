import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:ilkbizde/modules/MyStoreInfo/MyStoreInfoController.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/widgets/CustomButton.dart';
import 'package:sizer/sizer.dart';

class CustomMarketInfosBottomSheetWidget extends StatelessWidget {
  final MyStoreInfoController controller;
  final String buttonTitle;
  final void Function()? onTap;
  const CustomMarketInfosBottomSheetWidget({
    super.key,
    required this.controller,
    required this.buttonTitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 5.w,
          vertical: 2.h,
        ),
        decoration: BoxDecoration(
          color: Get.isDarkMode ? AppColors.SOOTY : AppColors.WHITE,
          borderRadius: AppBorderRadius.inputRadius,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: controller.categories.first.kategoriBilgileri.length,
              separatorBuilder: (context, _) => Direction.vertical.spacer(2),
              itemBuilder: (context, _index) {
                return getMarketInfoWidgetFromFilterType
                    .getFilterType(
                      controller.categories.first.kategoriBilgileri[_index]
                          .filterType,
                    )
                    .getWidget(
                        controller.categories.first.kategoriBilgileri[_index]
                            .filterName,
                        controller.marketInfos,
                        context,
                        _index);
              },
            ),
            Direction.vertical.spacer(1),
            Obx(
              () => Column(
                children: [
                  controller.image.value.path.isNotEmpty
                      ? ClipRRect(
                          borderRadius: AppBorderRadius.inputRadius,
                          child: Image.file(
                            controller.image.value,
                            fit: BoxFit.cover,
                          ),
                        )
                      : SizedBox.shrink(),
                  Direction.vertical.spacer(2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Bounceable(
                        onTap: () => controller.pickImage(),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 5.w,
                            vertical: 1.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.YANG_CHENG_ORANGE,
                            border: Border.all(
                              width: .5.w,
                              color: AppColors.BITCOIN,
                            ),
                            borderRadius: AppBorderRadius.inputRadius,
                          ),
                          child: Icon(
                            Icons.image_outlined,
                            color: AppColors.WHITE,
                          ),
                        ),
                      ),
                      Direction.horizontal.spacer(2),
                      controller.image.value.path.isEmpty
                          ? SizedBox.shrink()
                          : Bounceable(
                              onTap: () {
                                controller.image.value = File("");
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 5.w,
                                  vertical: 1.h,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.YANG_CHENG_ORANGE,
                                  border: Border.all(
                                    width: .5.w,
                                    color: AppColors.BITCOIN,
                                  ),
                                  borderRadius: AppBorderRadius.inputRadius,
                                ),
                                child: Icon(
                                  Icons.delete_outline,
                                  color: AppColors.WHITE,
                                ),
                              ),
                            ),
                    ],
                  ),
                ],
              ),
            ),
            Direction.vertical.spacer(2),
            SizedBox(
              height: 5.5.h,
              child: Obx(
                () => CustomButton(
                  title: buttonTitle,
                  isLoading: controller.createStoreLoading.value,
                  bg: AppColors.ALOHA,
                  onTap: onTap,
                ),
              ),
            ),
            Direction.vertical.spacer(6),
          ],
        ),
      ),
    );
  }
}
