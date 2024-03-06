// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:ilkbizde/modules/AdvertisementDetail/index.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/enum/images.dart';
import 'package:ilkbizde/shared/helpers/getBadge.dart';
import 'package:ilkbizde/shared/widgets/index.dart';
import 'package:sizer/sizer.dart';

class CustomAdvertisementCard extends StatelessWidget {
  final String title;
  final void Function() onTap;
  final String location;
  final String price;
  final Widget image;
  final bool isFavoriteAdvertisement;
  final void Function()? onFavoriteTap;
  RxBool isLoading = false.obs;
  final bool hasStyle;
  final String? adId;
  final bool hasUrgent;
  final bool hasPriceDrop;
  final HtmlUnescape unescape = HtmlUnescape();
  CustomAdvertisementCard({
    super.key,
    required this.title,
    required this.onTap,
    required this.location,
    required this.price,
    required this.image,
    this.isFavoriteAdvertisement = false,
    this.onFavoriteTap,
    required this.isLoading,
    required this.hasStyle,
    this.adId,
    required this.hasUrgent,
    required this.hasPriceDrop,
  });

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: onTap,
      child: Container(
        width: 100.w,
        decoration: BoxDecoration(
          color: Get.isDarkMode
              ? AppColors.BLACK_WASH
              : hasStyle
                  ? AppColors.LIGHT_GREEN_GLINT
                  : AppColors.WHITE,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 5),
              blurRadius: 15,
              spreadRadius: -5,
              color: AppColors.BLACK.withOpacity(.15),
            ),
          ],
        ),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 2.w,
                vertical: .4.h,
              ),
              child: Row(
                children: [
                  Stack(
                    alignment: Alignment.topLeft,
                    children: [
                      SizedBox(
                        width: 25.w,
                        height: 9.5.h,
                        child: image,
                      ),
                      Positioned(
                        child: getBadge(hasUrgent, hasPriceDrop),
                      ),
                    ],
                  ),
                  Direction.horizontal.spacer(2),
                  Expanded(
                    child: Obx(() => isLoading.value
                        ? const CustomShimmerLoading(
                            child: CustomPopularAdvertisementSkeleton(),
                          )
                        : Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            unescape.convert(title),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall
                                                ?.copyWith(
                                                  fontSize: 8.4.sp,
                                                  fontFamily: hasStyle
                                                      ? AppFonts.bold
                                                      : null,
                                                ),
                                          ),
                                        ),
                                        isFavoriteAdvertisement
                                            ? Direction.horizontal.spacer(2)
                                            : const SizedBox.shrink(),
                                        Get.isDarkMode
                                            ? Container(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 1.w,
                                                  vertical: .1.h,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: AppColors
                                                      .ROMAN_EMPIRE_RED,
                                                  borderRadius: AppBorderRadius
                                                      .inputRadius,
                                                ),
                                                child: Text(
                                                  "Pasif İlan",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall
                                                      ?.copyWith(
                                                        color: AppColors.WHITE,
                                                        fontFamily: hasStyle
                                                            ? AppFonts.bold
                                                            : null,
                                                      ),
                                                ),
                                              )
                                            : isFavoriteAdvertisement
                                                ? Bounceable(
                                                    onTap: onFavoriteTap,
                                                    child: Container(
                                                      width: 2.8.h,
                                                      height: 2.8.h,
                                                      padding: EdgeInsets.all(
                                                          4.1.sp),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            AppBorderRadius
                                                                .inputRadius,
                                                        color: AppColors
                                                            .SHY_MOMENT
                                                            .withOpacity(.1),
                                                      ),
                                                      child: Center(
                                                        child: Icon(
                                                          Icons.favorite,
                                                          color: AppColors
                                                              .HORNET_STING,
                                                          size: 1.6.h,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : const SizedBox.shrink(),
                                      ],
                                    ),
                                    Get.isDarkMode
                                        ? Align(
                                            alignment: Alignment.centerRight,
                                            child: Container(
                                              margin:
                                                  EdgeInsets.only(top: .5.h),
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 1.w,
                                                vertical: .1.h,
                                              ),
                                              decoration: BoxDecoration(
                                                color: AppColors.SAILER_MOON,
                                                borderRadius:
                                                    AppBorderRadius.inputRadius,
                                              ),
                                              child: Text(
                                                "Onay Sürecinde",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall
                                                    ?.copyWith(
                                                      color: AppColors.BLACK,
                                                      fontFamily: hasStyle
                                                          ? AppFonts.bold
                                                          : null,
                                                    ),
                                              ),
                                            ),
                                          )
                                        : SizedBox.shrink(),
                                    Get.isDarkMode
                                        ? Bounceable(
                                            onTap: () {
                                              final AdvertisementDetailController
                                                  controller =
                                                  Get.put<AdvertisementDetailController>(
                                                      AdvertisementDetailController());
                                              controller.createComplaintDialog(
                                                  context,
                                                  adId: adId);
                                            },
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: Container(
                                                margin:
                                                    EdgeInsets.only(top: .5.h),
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 1.w,
                                                  vertical: .1.h,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: AppColors
                                                      .VOLUPTUOUS_VIOLET,
                                                  borderRadius: AppBorderRadius
                                                      .inputRadius,
                                                ),
                                                child: Text(
                                                  "Şikayet Et",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall
                                                      ?.copyWith(
                                                        color: AppColors.WHITE,
                                                        fontFamily: hasStyle
                                                            ? AppFonts.bold
                                                            : null,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          )
                                        : SizedBox.shrink(),
                                    Direction.vertical.spacer(2.5),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Images.pin.pngWithColor(
                                                Get.isDarkMode
                                                    ? AppColors.MILLION_GREY
                                                    : AppColors
                                                        .ASHENVALE_NIGHTS,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  location,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall
                                                      ?.copyWith(
                                                        fontFamily: hasStyle
                                                            ? AppFonts.bold
                                                            : null,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          price.replaceAllMapped(
                                              RegExp(
                                                  r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                              (Match m) => '${m[1]}.'),
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium
                                              ?.copyWith(
                                                color:
                                                    AppColors.ROMAN_EMPIRE_RED,
                                                fontFamily: AppFonts.semiBold,
                                              ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
