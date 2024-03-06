// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:ilkbizde/modules/AdvertisementDetail/AdvertisementDetailController.dart';
import 'package:ilkbizde/modules/AdvertisementDetail/widgets/index.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/enum/images.dart';
import 'package:ilkbizde/shared/widgets/index.dart';
import 'package:sizer/sizer.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CustomAdsInfoTab extends StatelessWidget {
  const CustomAdsInfoTab({
    super.key,
    required this.controller,
  });

  final AdvertisementDetailController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // SABİT ÖZELLİKLER
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 3.w),
          shrinkWrap: true,
          itemCount: controller.adDetailsInfo[0].adInfo.length,
          separatorBuilder: (context, index) => CustomSeperatorWidget(
            color: AppColors.SHY_MOMENT.withOpacity(.1),
          ),
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 1.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    controller.adDetailsInfo[0].adInfo[index].key ?? "",
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Get.isDarkMode ? null : AppColors.BLACK,
                        ),
                  ),
                  controller.adDetailsInfo[0].adInfo[index].key == "Fiyat"
                      ? Text(
                          controller.adDetailsInfo[0].adInfo[index].value ?? "",
                          style:
                              Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: AppColors.ROMAN_EMPIRE_RED,
                                    fontFamily: AppFonts.semiBold,
                                  ),
                        )
                      : (controller.adDetailsInfo[0].adInfo[index].key ?? "")
                              .contains("Parsel Sorgu")
                          ? Bounceable(
                              onTap: () => controller.parcelInquiry(
                                  url: controller.adDetailsInfo[0].adInfo[index]
                                          .value ??
                                      ""),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 3.w, vertical: .5.h),
                                decoration: BoxDecoration(
                                  color: AppColors.CLEAR_CHILL,
                                  borderRadius: AppBorderRadius.inputRadius,
                                ),
                                child: Text(
                                  AppStrings.query,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(
                                        color: AppColors.WHITE,
                                      ),
                                ),
                              ),
                            )
                          : Text(
                              (controller.adDetailsInfo[0].adInfo[index]
                                              .value ??
                                          "")
                                      .isEmpty
                                  ? "Belirtilmemiş"
                                  : controller.adDetailsInfo[0].adInfo[index]
                                          .value ??
                                      "",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                    fontFamily: controller
                                            .adDetailsInfo[0].adInfo[index].key!
                                            .contains("İlan No")
                                        ? AppFonts.semiBold
                                        : null,
                                    color: controller
                                            .adDetailsInfo[0].adInfo[index].key!
                                            .contains("İlan No")
                                        ? AppColors.ASHENVALE_NIGHTS
                                        : AppColors.STEEL,
                                  ),
                            ),
                ],
              ),
            );
          },
        ),
        controller.adDetailsInfo[0].dinamikOzellikler.isEmpty
            ? const SizedBox.shrink()
            : Container(
                width: 100.w,
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                decoration: BoxDecoration(
                  color: Get.isDarkMode
                      ? AppColors.BLACK_WASH
                      : AppColors.WHITE_SMOKE,
                ),
                child: Text(
                  AppStrings.features,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Get.isDarkMode ? null : AppColors.STEEL,
                      ),
                ),
              ),
        // DİNAMİK ÖZELLİKLER
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: 3.w,
          ),
          shrinkWrap: true,
          itemCount: controller.adDetailsInfo[0].dinamikOzellikler.length,
          separatorBuilder: (context, index) => CustomSeperatorWidget(
            color: AppColors.SHY_MOMENT.withOpacity(.1),
          ),
          itemBuilder: (context, index) {
            return (controller.adDetailsInfo[0].dinamikOzellikler[index]
                                .features ??
                            [])
                        .length >
                    1
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Direction.vertical.spacer(1),
                      Text(
                        controller.adDetailsInfo[0].dinamikOzellikler[index]
                            .groupName,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: Get.isDarkMode ? null : AppColors.BLACK,
                            ),
                      ),
                      Direction.vertical.spacer(1),
                      CustomSeperatorWidget(
                        color: AppColors.SHY_MOMENT.withOpacity(.1),
                      ),
                      ListView.separated(
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, dynamicFeaturesIndex) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 1.h),
                            child: Text(
                              controller
                                  .adDetailsInfo[0]
                                  .dinamikOzellikler[index]
                                  .features![dynamicFeaturesIndex],
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                    color: AppColors.STEEL,
                                  ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            CustomSeperatorWidget(
                          color: AppColors.SHY_MOMENT.withOpacity(.1),
                        ),
                        itemCount: controller.adDetailsInfo[0]
                                .dinamikOzellikler[index].features?.length ??
                            0,
                      ),
                    ],
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(vertical: 1.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          controller.adDetailsInfo[0].dinamikOzellikler[index]
                              .groupName,
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(
                                color: Get.isDarkMode ? null : AppColors.BLACK,
                              ),
                        ),
                        Text(
                          controller.adDetailsInfo[0].dinamikOzellikler[index]
                                      .features ==
                                  null
                              ? "Belirtilmemiş"
                              : controller
                                      .adDetailsInfo[0]
                                      .dinamikOzellikler[index]
                                      .features
                                      ?.first ??
                                  "",
                          style:
                              Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: AppColors.STEEL,
                                  ),
                        ),
                      ],
                    ),
                  );
          },
        ),

        (controller.adDetailsInfo[0].ekspertiz ?? "").isEmpty
            ? const SizedBox.shrink()
            : Column(
                children: [
                  Container(
                    width: 100.w,
                    padding:
                        EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                    decoration: BoxDecoration(
                      color: Get.isDarkMode
                          ? AppColors.BLACK_WASH
                          : AppColors.WHITE_SMOKE,
                    ),
                    child: Text(
                      "BOYA,DEĞİŞEN VE EKSPERTİZ BİLGİSİ",
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: Get.isDarkMode ? null : AppColors.STEEL,
                          ),
                    ),
                  ),
                  Container(
                    height: 20.h,
                    padding: EdgeInsets.symmetric(horizontal: 3.w),
                    child: WebViewWidget(
                      controller: WebViewController()
                        ..setJavaScriptMode(JavaScriptMode.unrestricted)
                        ..setBackgroundColor(const Color(0x00000000))
                        ..setNavigationDelegate(
                          NavigationDelegate(
                            onProgress: (int progress) {
                              // Update loading bar.
                            },
                          ),
                        )
                        ..loadHtmlString(
                          controller.adDetailsInfo[0].ekspertiz ?? "",
                        ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.w),
                    child: Column(
                      children: [
                        (controller.adDetailsInfo[0].degisenler ?? []).isEmpty
                            ? const SizedBox.shrink()
                            : CustomExpertiseInfo(
                                parts: controller.adDetailsInfo[0].degisenler ??
                                    [],
                                title: "Değişen Parçalar",
                                partsTitleColor: AppColors.GLOOMY_PURPLE,
                              ),
                        (controller.adDetailsInfo[0].boyalilar ?? []).isEmpty
                            ? const SizedBox.shrink()
                            : CustomExpertiseInfo(
                                parts:
                                    controller.adDetailsInfo[0].boyalilar ?? [],
                                title: "Boyalı Parçalar",
                                partsTitleColor: AppColors.TOXIC_ORANGE,
                              ),
                        (controller.adDetailsInfo[0].blokalBoyalar ?? [])
                                .isEmpty
                            ? const SizedBox.shrink()
                            : CustomExpertiseInfo(
                                parts:
                                    controller.adDetailsInfo[0].blokalBoyalar ??
                                        [],
                                title: "Lokal Boyalı Parçalar",
                                partsTitleColor: AppColors.MATCH_STRIKE,
                              ),
                      ],
                    ),
                  )
                ],
              ),

        CustomSeperatorWidget(
          color: AppColors.SHY_MOMENT.withOpacity(.1),
        ),
        Obx(
          () => CustomAdsDetailIconButton(
            title: AppStrings.compareAds,
            icon: Images.compare,
            onTap: controller.isCompareLoading.value
                ? () {}
                : () {
                    controller.handleCompare(context);
                  },
          ),
        ),
        CustomSeperatorWidget(
          color: AppColors.SHY_MOMENT.withOpacity(.1),
        ),
        CustomAdsDetailIconButton(
          title: AppStrings.complaintAds,
          icon: Images.complaint,
          onTap: () {
            controller.createComplaintDialog(context);
          },
        ),
        CustomSeperatorWidget(
          color: AppColors.SHY_MOMENT.withOpacity(.1),
        ),
        Direction.vertical.spacer(9),
      ],
    );
  }
}
