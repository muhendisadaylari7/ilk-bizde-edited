// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:ilkbizde/modules/Home/index.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/enum/images.dart';
import 'package:ilkbizde/shared/extensions/ImageUrlType.dart';
import 'package:ilkbizde/shared/widgets/index.dart';
import 'package:sizer/sizer.dart';

class CustomDailyOpportunityAdsCard extends StatelessWidget {
  RxBool isLoading = false.obs;
  final HomeController controller;
  final int index;
  final bool hasButton;
  final void Function()? onTap;
  final HtmlUnescape unescape = HtmlUnescape();
  CustomDailyOpportunityAdsCard({
    super.key,
    required this.isLoading,
    required this.controller,
    required this.index,
    this.hasButton = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 100.w,
            padding: EdgeInsets.symmetric(
              horizontal: 2.w,
              vertical: 1.h,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: hasButton
                    ? AppColors.ASHENVALE_NIGHTS
                    : AppColors.ROMAN_EMPIRE_RED,
                width: .6.w,
              ),
              borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
              color: AppColors.WHITE,
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 4),
                  blurRadius: 4,
                  spreadRadius: 0,
                  color: AppColors.BLACK.withOpacity(.25),
                )
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    child: Row(
                      children: [
                        // BİRİNCİ RESİM
                        Expanded(
                          child: Container(
                            height: 14.h,
                            child: controller
                                    .dailyOpportunityAdvertisements[index]
                                    .adPics
                                    .isNotEmpty
                                ? ClipRRect(
                                    borderRadius: AppBorderRadius.inputRadius,
                                    child: CachedNetworkImage(
                                      imageUrl: ImageUrlTypeExtension
                                              .getImageType(controller
                                                  .dailyOpportunityAdvertisements[
                                                      index]
                                                  .adPics
                                                  .split(",")
                                                  .first)
                                          .ImageUrlList(
                                              controller
                                                  .dailyOpportunityAdvertisements[
                                                      index]
                                                  .adPics,
                                              0),
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Images.noImages.pngWithScale,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              // İKİNCİ RESİM
                              Container(
                                height: 4.h,
                                decoration: BoxDecoration(
                                  borderRadius: AppBorderRadius.inputRadius,
                                ),
                                child: controller
                                            .dailyOpportunityAdvertisements[
                                                index]
                                            .adPics
                                            .isNotEmpty &&
                                        controller
                                                .dailyOpportunityAdvertisements[
                                                    index]
                                                .adPics
                                                .split(",")
                                                .length >=
                                            2
                                    ? CachedNetworkImage(
                                        imageUrl: ImageUrlTypeExtension
                                                .getImageType(controller
                                                    .dailyOpportunityAdvertisements[
                                                        index]
                                                    .adPics
                                                    .split(",")
                                                    .first)
                                            .ImageUrlList(
                                                controller
                                                    .dailyOpportunityAdvertisements[
                                                        index]
                                                    .adPics,
                                                1),
                                        fit: BoxFit.cover,
                                      )
                                    : Images.noImages.pngWithScale,
                              ),
                              Direction.vertical.spacer(1),
                              // ÜÇÜNCÜ RESİM
                              Container(
                                height: 4.h,
                                decoration: BoxDecoration(
                                  borderRadius: AppBorderRadius.inputRadius,
                                ),
                                child: controller
                                            .dailyOpportunityAdvertisements[
                                                index]
                                            .adPics
                                            .isNotEmpty &&
                                        controller
                                                .dailyOpportunityAdvertisements[
                                                    index]
                                                .adPics
                                                .split(",")
                                                .length >=
                                            3
                                    ? CachedNetworkImage(
                                        imageUrl: ImageUrlTypeExtension
                                                .getImageType(controller
                                                    .dailyOpportunityAdvertisements[
                                                        index]
                                                    .adPics
                                                    .split(",")
                                                    .first)
                                            .ImageUrlList(
                                                controller
                                                    .dailyOpportunityAdvertisements[
                                                        index]
                                                    .adPics,
                                                2),
                                        fit: BoxFit.cover,
                                      )
                                    : Images.noImages.pngWithScale,
                              ),
                              Direction.vertical.spacer(1),
                              // DÖRDÜNCÜ RESİM
                              Container(
                                height: 4.h,
                                decoration: BoxDecoration(
                                  borderRadius: AppBorderRadius.inputRadius,
                                ),
                                child: controller
                                            .dailyOpportunityAdvertisements[
                                                index]
                                            .adPics
                                            .isNotEmpty &&
                                        controller
                                                .dailyOpportunityAdvertisements[
                                                    index]
                                                .adPics
                                                .split(",")
                                                .length >=
                                            4
                                    ? CachedNetworkImage(
                                        imageUrl: ImageUrlTypeExtension
                                                .getImageType(controller
                                                    .dailyOpportunityAdvertisements[
                                                        index]
                                                    .adPics
                                                    .split(",")
                                                    .first)
                                            .ImageUrlList(
                                                controller
                                                    .dailyOpportunityAdvertisements[
                                                        index]
                                                    .adPics,
                                                3),
                                        fit: BoxFit.cover,
                                      )
                                    : Images.noImages.pngWithScale,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Direction.horizontal.spacer(1),
                Expanded(
                  child: Obx(
                    () => controller.isLoading.value
                        ? const CustomShimmerLoading(
                            child: CustomShowcaseAdvertisementSkeleton(),
                          )
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  height: 14.h,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        unescape.convert(controller
                                            .dailyOpportunityAdvertisements[
                                                index]
                                            .adSubject),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall,
                                      ),
                                      Text(
                                        "${controller.dailyOpportunityAdvertisements[index].adPrice} ${controller.dailyOpportunityAdvertisements[index].adCurrency}",
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall
                                            ?.copyWith(
                                              color: AppColors.ROMAN_EMPIRE_RED,
                                              fontSize: 6.5.sp,
                                              fontFamily: AppFonts.medium,
                                            ),
                                      ),
                                      Row(
                                        children: [
                                          Images.pin.pngWithColor(
                                              AppColors.ASHENVALE_NIGHTS),
                                          Text(
                                            controller
                                                    .dailyOpportunityAdvertisements[
                                                        index]
                                                    .adCity +
                                                "," +
                                                controller
                                                    .dailyOpportunityAdvertisements[
                                                        index]
                                                    .adDistrict,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall
                                                ?.copyWith(
                                                  color: AppColors
                                                      .ASHENVALE_NIGHTS,
                                                  fontSize: 6.5.sp,
                                                  fontFamily: AppFonts.medium,
                                                ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "İlana Kalan Süre: ${controller.dailyOpportunityAdvertisements[index].adRemHour} Saat ${controller.dailyOpportunityAdvertisements[index].adRemMin} Dakika",
                                        maxLines: 2,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall
                                            ?.copyWith(
                                              color: AppColors.ASHENVALE_NIGHTS,
                                              fontSize: 6.5.sp,
                                              fontFamily: AppFonts.medium,
                                            ),
                                      ),
                                      hasButton
                                          ? Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 1.5.w,
                                                vertical: .5.h,
                                              ),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: AppColors
                                                      .ASHENVALE_NIGHTS,
                                                  width: .3.w,
                                                ),
                                                borderRadius:
                                                    AppBorderRadius.inputRadius,
                                                color: AppColors
                                                    .ZHELEZNOGORSK_YELLOW,
                                              ),
                                              child: Text(
                                                "Günün Fırsatını İncele",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelSmall
                                                    ?.copyWith(
                                                      color: AppColors
                                                          .ASHENVALE_NIGHTS,
                                                      fontSize: 7.sp,
                                                      fontFamily:
                                                          AppFonts.medium,
                                                    ),
                                              ),
                                            )
                                          : SizedBox.shrink(),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 100.w,
            padding: EdgeInsets.symmetric(vertical: .5.h),
            decoration: BoxDecoration(
              color: hasButton
                  ? AppColors.ASHENVALE_NIGHTS
                  : AppColors.ROMAN_EMPIRE_RED,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(8),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 2.h,
                  height: 2.h,
                  child: Images.clock.pngWithColor(
                    AppColors.WHITE,
                  ),
                ),
                Direction.horizontal.spacer(1),
                Text(
                  "Bu ilan 24 saat geçerlidir, günün fırsat ilanıdır.",
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.WHITE,
                        fontSize: 10.sp,
                        fontFamily: AppFonts.light,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
