// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/helpers/getBadge.dart';
import 'package:ilkbizde/shared/widgets/index.dart';
import 'package:sizer/sizer.dart';

class CustomSliderItem extends StatelessWidget {
  final void Function() onTap;
  final String title;
  final String price;
  final void Function() favoriteOnTap;
  final Widget image;
  final int isFavorite;
  RxBool isLoading = false.obs;
  final bool hasUrgent;
  final bool hasPriceDrop;
  final HtmlUnescape unescape = HtmlUnescape();
  CustomSliderItem({
    super.key,
    required this.onTap,
    required this.title,
    required this.price,
    required this.favoriteOnTap,
    required this.image,
    required this.isFavorite,
    required this.isLoading,
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
            borderRadius: AppBorderRadius.inputRadius,
            color: AppColors.WHITE,
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 4),
                blurRadius: 4,
                spreadRadius: 0,
                color: AppColors.BLACK.withOpacity(.25),
              )
            ]),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 2.w,
            vertical: 1.h,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                alignment: Alignment.topLeft,
                children: [
                  SizedBox(
                    width: 7.h,
                    height: 7.h,
                    child: image,
                  ),
                  Positioned(
                    child: getBadge(hasUrgent, hasPriceDrop),
                  ),
                ],
              ),
              Direction.horizontal.spacer(1),
              Expanded(
                child: Obx(
                  () => isLoading.value
                      ? const CustomShimmerLoading(
                          child: CustomShowcaseAdvertisementSkeleton(),
                        )
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 7.h,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        unescape.convert(title),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall,
                                      ),
                                    ),
                                    Text(
                                      price,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall
                                          ?.copyWith(
                                            color: AppColors.ROMAN_EMPIRE_RED,
                                            fontSize: 6.5.sp,
                                            fontFamily: AppFonts.semiBold,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Direction.horizontal.spacer(1),
                            Bounceable(
                              onTap: favoriteOnTap,
                              child: Container(
                                width: 6.w,
                                height: 6.w,
                                padding: EdgeInsets.all(4.1.sp),
                                decoration: BoxDecoration(
                                  borderRadius: AppBorderRadius.inputRadius,
                                  color: AppColors.SHY_MOMENT.withOpacity(.1),
                                ),
                                child: Center(
                                  child: Icon(
                                    isFavorite == 1
                                        ? Icons.favorite
                                        : Icons.favorite_border_outlined,
                                    color: isFavorite == 1
                                        ? AppColors.HORNET_STING
                                        : AppColors.SHY_MOMENT,
                                    size: 10.5.sp,
                                  ),
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
      ),
    );
  }
}
