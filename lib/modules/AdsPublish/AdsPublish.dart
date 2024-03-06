// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilkbizde/modules/AdsPublish/AdsPublishController.dart';
import 'package:ilkbizde/modules/AdsPublish/widgets/CustomAdsPreviewInfos.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/extensions/CustomSnackbar.dart';
import 'package:ilkbizde/shared/widgets/index.dart';
import 'package:sizer/sizer.dart';

class AdsPublish extends StatefulWidget {
  const AdsPublish({super.key});

  @override
  State<AdsPublish> createState() => _AdsPublishState();
}

class _AdsPublishState extends State<AdsPublish> {
  final AdsPublishController controller = Get.put(AdsPublishController());

  @override
  Widget build(BuildContext context) {
    Get.put(AdsPublishController());

    return Obx(
      () => Scaffold(
        appBar: CustomMyAccountItemAppBar(
          title: controller.createAdsSteps[controller.currentPageIndex.value]
              ["title"],
          onBackButtonPressed: controller.currentPageIndex.value == 4 &&
                  controller.parameters["buyDoping"] == "1"
              ? null
              : () {
                  if (controller.currentPageIndex.value == 3) {
                    controller.watermark.removeWatermark();
                  }
                  if (controller.currentPageIndex.value == 4) {
                    controller.watermark.addCustomWatermark(
                      context,
                      const Watermark(
                          rowCount: 2, columnCount: 3, text: "ÖNİZLEME"),
                    );
                  }
                  controller.currentPageIndex.value == 0
                      ? Get.back()
                      : controller.currentPageIndex.value == 2
                          ? controller.pageController.jumpToPage(0)
                          : controller.currentPageIndex.value == 3
                              ? controller.pageController.jumpToPage(2)
                              : controller.pageController.previousPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.ease,
                                );
                  if (controller.isShowcasePhoto.value) {
                    controller.isShowcasePhoto.value = false;
                  }
                },
        ),
        body: WillPopScope(
          onWillPop: controller.currentPageIndex.value == 4 &&
                  controller.parameters["buyDoping"] == "1"
              ? null
              : () async {
                  if (controller.currentPageIndex.value == 0) return true;
                  if (controller.currentPageIndex.value == 3) {
                    controller.watermark.removeWatermark();
                  }
                  if (controller.currentPageIndex.value == 4) {
                    controller.watermark.addCustomWatermark(
                      context,
                      const Watermark(
                          rowCount: 2, columnCount: 3, text: "ÖNİZLEME"),
                    );
                  }
                  controller.currentPageIndex.value == 2
                      ? controller.pageController.jumpToPage(0)
                      : controller.currentPageIndex.value == 3
                          ? controller.pageController.jumpToPage(2)
                          : controller.pageController.previousPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                  if (controller.isShowcasePhoto.value) {
                    controller.isShowcasePhoto.value = false;
                  }
                  return false;
                },
          child: controller.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.ASHENVALE_NIGHTS,
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                      child: PageView.builder(
                        itemCount: controller.createAdsSteps.length,
                        controller: controller.pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        onPageChanged: (value) {
                          controller.currentPageIndex.value = value;
                        },
                        itemBuilder: (_, index) =>
                            controller.createAdsSteps[index]["widget"],
                      ),
                    ),
                    Container(
                      width: 100.w,
                      padding: EdgeInsets.symmetric(
                          horizontal: 5.w, vertical: 1.5.h),
                      decoration: BoxDecoration(
                        color: AppColors.WHITE,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.BLACK.withOpacity(.15),
                            blurRadius: 4,
                            spreadRadius: 0,
                            offset: const Offset(0, -4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          controller.currentPageIndex.value == 4
                              ? Expanded(
                                  flex: 3,
                                  child: CustomTextRich(
                                    text1: "Toplam Tutar: ",
                                    text2Color: AppColors.FENNEL_FIESTA,
                                    text2:
                                        "₺${controller.totalPrice.value.toString()}",
                                    text2OnTap: null,
                                  ),
                                )
                              : Column(
                                  children: [
                                    Text(
                                      "${controller.createAdsSteps[controller.currentPageIndex.value]["title"]} (${controller.currentPageIndex.value + 1}/${controller.createAdsSteps.length})",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall
                                          ?.copyWith(
                                            color: AppColors.COLD_GREY,
                                            fontFamily: AppFonts.light,
                                          ),
                                    ),
                                    Direction.vertical.spacer(1),
                                    Container(
                                        width: 40.w,
                                        height: .7.h,
                                        alignment: Alignment.centerLeft,
                                        decoration: BoxDecoration(
                                          color: AppColors.SO_SHY,
                                          borderRadius:
                                              AppBorderRadius.inputRadius,
                                        ),
                                        child: AnimatedContainer(
                                          duration:
                                              const Duration(milliseconds: 500),
                                          width: 40.w *
                                              ((controller.currentPageIndex
                                                          .value +
                                                      1) /
                                                  controller
                                                      .createAdsSteps.length),
                                          decoration: BoxDecoration(
                                            color: AppColors.BLUE_RIBBON,
                                            borderRadius:
                                                AppBorderRadius.inputRadius,
                                          ),
                                        ))
                                  ],
                                ),
                          Direction.horizontal.spacer(3),
                          Expanded(
                            flex: 3,
                            child: CustomButton(
                              isLoading: controller.isStepLoading.value,
                              height: 5.h,
                              title: controller.currentPageIndex.value == 4
                                  ? controller.parameters["isEdit"] != null
                                      ? "İlanı Güncelle"
                                      : "İlanı Oluştur"
                                  : controller.parameters["isEdit"] != null
                                      ? "Güncelle"
                                      : "Devam Et",
                              bg: AppColors.ASHENVALE_NIGHTS,
                              onTap: () async {
                                if (controller.isPhotoAndVideoLoading.value) {
                                  SnackbarType.error.CustomSnackbar(
                                      title: AppStrings.error,
                                      message:
                                          "Lütfen fotoğraf ve video yüklemelerinin tamamlanmasını bekleyiniz.");
                                  await Future.delayed(
                                      const Duration(seconds: 2),
                                      () => Get.back());
                                  return;
                                }
                                if (controller.currentPageIndex.value == 0 &&
                                    controller.formKey.currentState!
                                        .validate()) {
                                  if (controller.imageList.isEmpty) {
                                    SnackbarType.error.CustomSnackbar(
                                        title: AppStrings.error,
                                        message:
                                            "En az 1 görsel yüklemeniz gerekmektedir.");
                                    await Future.delayed(
                                        const Duration(seconds: 2),
                                        () => Get.back());
                                    return;
                                  }
                                  await controller.getDopingFilter();
                                  await controller.handleDefaultInfos();
                                } else if (controller.currentPageIndex.value ==
                                    1) {
                                  controller.pageController.jumpToPage(0);
                                  if (controller.imageList.isNotEmpty) {
                                    controller.uploadPhotoAndVideo();
                                  }
                                } else if (controller.currentPageIndex.value ==
                                    2) {
                                  await controller.handleAddressInfos(context);
                                } else if (controller.currentPageIndex.value ==
                                    3) {
                                  controller.watermark.removeWatermark();
                                  controller.pageController.nextPage(
                                    duration: const Duration(
                                      milliseconds: 500,
                                    ),
                                    curve: Curves.easeIn,
                                  );
                                } else if (controller.currentPageIndex.value ==
                                    4) {
                                  await controller.handleDopingInfos();
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Direction.vertical.spacer(2),
                  ],
                ),
        ),
      ),
    );
  }
}
