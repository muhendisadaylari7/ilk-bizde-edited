// ignore_for_file: file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilkbizde/modules/AdvertisementDetail/AdvertisementDetailController.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/extensions/ImageUrlType.dart';
import 'package:ilkbizde/shared/widgets/CustomIconButton.dart';
import 'package:sizer/sizer.dart';

class CustomSliderPhotoFocus extends StatelessWidget {
  final AdvertisementDetailController controller;

  const CustomSliderPhotoFocus({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BLACK.withOpacity(.5),
      body: WillPopScope(
        onWillPop: () async {
          controller.pageController.animateToPage(
            controller.currenPageIndex.value,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeIn,
          );
          return true;
        },
        child: SafeArea(
          child: Obx(
            () => Stack(
              alignment: Alignment.center,
              children: [
                PageView.builder(
                  controller: PageController(
                      initialPage: controller.currenPageIndex.value),
                  itemCount: controller.adDetailsInfo[0].adPicCount,
                  onPageChanged: (value) {
                    controller.currenPageIndex.value = value;
                  },
                  itemBuilder: (context, index) {
                    return CachedNetworkImage(
                      imageUrl: ImageUrlTypeExtension.getImageType(
                        controller.adDetailsInfo.first.adPic.split(",")[index],
                      ).ImageUrlList(
                          controller.adDetailsInfo.first.adPic, index),
                    );
                  },
                ),
                Positioned(
                  bottom: 0,
                  width: 15.w,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.BLACK.withOpacity(.5),
                      borderRadius: BorderRadius.circular(
                        14.sp,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "${controller.currenPageIndex.value + 1}/${controller.adDetailsInfo[0].adPicCount}",
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: AppColors.WHITE,
                          ),
                    ),
                  ),
                ),
                Positioned(
                  top: 2.h,
                  right: 2.h,
                  child: CustomIconButton(
                    onTap: () {
                      controller.pageController.animateToPage(
                        controller.currenPageIndex.value,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                      );
                      Get.back();
                    },
                    child: Icon(
                      Icons.close,
                      color: AppColors.WHITE,
                      size: 13.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
