// ignore_for_file: file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:ilkbizde/controllers/NetworkController.dart';
import 'package:ilkbizde/modules/MyAdsDetail/MyAdsDetailController.dart';
import 'package:ilkbizde/routes/app_pages.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/enum/images.dart';
import 'package:ilkbizde/shared/enum/myAdsType.dart';
import 'package:ilkbizde/shared/extensions/ImageUrlType.dart';
import 'package:ilkbizde/shared/widgets/index.dart';
import 'package:sizer/sizer.dart';

class MyAdsDetail extends StatefulWidget {
  const MyAdsDetail({super.key});

  @override
  State<MyAdsDetail> createState() => _MyAdsDetailState();
}

class _MyAdsDetailState extends State<MyAdsDetail> {
  final MyAdsDetailController controller = Get.put(MyAdsDetailController());

  @override
  Widget build(BuildContext context) {
    Get.put(MyAdsDetailController());
    return Scaffold(
      appBar: CustomMyAccountItemAppBar(
        title: "${controller.parameters["adId"]} no'lu ilan",
      ),
      backgroundColor: Get.isDarkMode ? null : AppColors.ZHEN_ZHU_BAI_PEARL,
      body: GetBuilder<NetworkController>(builder: (networkController) {
        if (networkController.connectionType.value == 0) {
          return const CustomNoInternetWidget();
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Bounceable(
                  onTap: () {
                    Get.toNamed(
                      Routes.ADVERTISEMENTDETAIL +
                          controller
                              .myAdsController
                              .myAdsList[int.parse(
                                  controller.parameters["index"].toString())]
                              .adId
                              .toString(),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 3.w,
                      vertical: 1.h,
                    ),
                    decoration: BoxDecoration(
                      color: Get.isDarkMode
                          ? AppColors.BLACK_WASH
                          : AppColors.WHITE,
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(0, 5),
                            blurRadius: 15,
                            spreadRadius: -5,
                            color: AppColors.BLACK.withOpacity(.3))
                      ],
                    ),
                    width: 100.w,
                    child: Row(
                      children: [
                        controller
                                .myAdsController
                                .myAdsList[int.parse(
                                    controller.parameters["index"].toString())]
                                .adPics
                                .isEmpty
                            ? Images.noImages.pngWithColor(
                                Get.isDarkMode
                                    ? AppColors.WHITE
                                    : AppColors.BLACK,
                              )
                            : Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: AppBorderRadius.inputRadius,
                                    image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                        ImageUrlTypeExtension.getImageType(
                                                controller
                                                    .myAdsController
                                                    .myAdsList[int.parse(
                                                        controller
                                                            .parameters["index"]
                                                            .toString())]
                                                    .adPics
                                                    .split(",")
                                                    .first)
                                            .ImageUrl(controller
                                                .myAdsController
                                                .myAdsList[int.parse(controller
                                                    .parameters["index"]
                                                    .toString())]
                                                .adPics),
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  constraints: BoxConstraints(minHeight: 10.h),
                                ),
                              ),
                        Direction.horizontal.spacer(2),
                        Expanded(
                          flex: 3,
                          child: Container(
                            constraints: BoxConstraints(minHeight: 10.h),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller
                                      .myAdsController
                                      .myAdsList[int.parse(controller
                                          .parameters["index"]
                                          .toString())]
                                      .adSubject,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "İlanın Bitiş Tarihi: ${controller.myAdsController.myAdsList[int.parse(controller.parameters["index"].toString())].adEndDate}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall,
                                      ),
                                    ),
                                    Direction.horizontal.spacer(1),
                                    Text(
                                      "${controller.myAdsController.myAdsList[int.parse(controller.parameters["index"].toString())].adPrice} ${controller.myAdsController.myAdsList[int.parse(controller.parameters["index"].toString())].adCurrency}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall
                                          ?.copyWith(
                                            color: AppColors.ROMAN_EMPIRE_RED,
                                          ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Direction.vertical.spacer(2),
                CustomStatisticsInfoCard(
                    totalVisitors: controller
                        .myAdsController
                        .myAdsList[int.parse(
                            controller.parameters["index"].toString())]
                        .adTotalVisitors,
                    totalFavorites: controller
                        .myAdsController
                        .myAdsList[int.parse(
                            controller.parameters["index"].toString())]
                        .adTotalFav),
                Bounceable(
                  onTap: () async {
                    await controller.getDefaultInfos(
                      controller.parameters["adId"].toString(),
                      buyDoping: "1",
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 3.w,
                      vertical: 1.h,
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: AppColors.SHY_MOMENT.withOpacity(.2),
                        ),
                      ),
                      color: Get.isDarkMode
                          ? AppColors.BLACK_WASH
                          : AppColors.WHITE,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Images.buyDoping.pngWithColor(
                              Get.isDarkMode
                                  ? AppColors.WHITE
                                  : AppColors.BLACK,
                            ),
                            Direction.horizontal.spacer(1),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "İlana Doping Al!",
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                                Text(
                                  "Doping ile ilanı güçlendirin",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(
                                        fontFamily: AppFonts.light,
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Icon(
                          Icons.chevron_right_outlined,
                          color: AppColors.SILVER,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 3.w,
                vertical: 1.h,
              ),
              margin: EdgeInsets.only(bottom: 6.h),
              child: Column(
                children: [
                  Row(
                    children: [
                      Get.isDarkMode
                          ? const SizedBox.shrink()
                          : Expanded(
                              flex: 8,
                              child: Obx(
                                () => CustomButton(
                                  title: "Düzenle",
                                  isLoading: controller.isLoading.value,
                                  bg: AppColors.ASHENVALE_NIGHTS,
                                  onTap: () async {
                                    await controller.getDefaultInfos(controller
                                        .parameters["adId"]
                                        .toString());
                                  },
                                ),
                              ),
                            ),
                      Get.isDarkMode ? const SizedBox.shrink() : const Spacer(),
                      Expanded(
                        flex: 8,
                        child: CustomButton(
                          isLoading: controller.isDeleteLoading.value,
                          title: "Sil",
                          bg: AppColors.ASHENVALE_NIGHTS,
                          onTap: () {
                            Get.dialog(
                              Obx(
                                () => CustomAreUSureDialog(
                                  title:
                                      "İlanı silmek istediğinize emin misiniz?",
                                  isLoading: controller.isDeleteLoading.value,
                                  yesOnTap: () => controller.handleDelete(),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  controller.args[0] == MyAdsType.WAITING
                      ? const SizedBox.shrink()
                      : Column(
                          children: [
                            Direction.vertical.spacer(2),
                            Obx(
                              () => CustomButton(
                                title: controller
                                    .getButtonTitle(controller.args[0]),
                                bg: AppColors.ASHENVALE_NIGHTS,
                                isLoading: controller.isLoading.value,
                                onTap: () =>
                                    controller.handleAds(controller.args[0]),
                              ),
                            ),
                          ],
                        )
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}
