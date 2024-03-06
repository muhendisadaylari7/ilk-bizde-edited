import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:ilkbizde/data/model/MyAdvertisementResponseModel.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/enum/images.dart';
import 'package:ilkbizde/shared/extensions/ImageUrlType.dart';
import 'package:ilkbizde/shared/helpers/getBadge.dart';
import 'package:sizer/sizer.dart';

class CustomMyAdsCard extends StatelessWidget {
  final RxList<MyAdvertisementResponseModel> adsList;
  final int index;
  final void Function()? onTap;
  final bool hasStyle;
  final bool hasUrgent;
  final bool hasPriceDrop;
  const CustomMyAdsCard({
    super.key,
    required this.adsList,
    required this.index,
    this.onTap,
    required this.hasStyle,
    required this.hasUrgent,
    required this.hasPriceDrop,
  });

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: hasStyle
              ? AppColors.LIGHT_GREEN_GLINT
              : Get.isDarkMode
                  ? AppColors.BLACK_WASH
                  : AppColors.WHITE,
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 5),
                blurRadius: 15,
                spreadRadius: -5,
                color: AppColors.BLACK.withOpacity(.3))
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 3.w,
            vertical: 1.h,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    adsList[index].adPics.isEmpty
                        ? Images.noImages.pngWithColor(
                            Get.isDarkMode ? AppColors.WHITE : AppColors.BLACK,
                          )
                        : Container(
                            decoration: BoxDecoration(
                              borderRadius: AppBorderRadius.inputRadius,
                              image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                  ImageUrlTypeExtension.getImageType(
                                          adsList[index]
                                              .adPics
                                              .split(",")
                                              .first)
                                      .ImageUrl(
                                    adsList[index].adPics,
                                  ),
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                            alignment: Alignment.topLeft,
                            child: getBadge(hasUrgent, hasPriceDrop),
                            constraints: BoxConstraints(minHeight: 10.h),
                          ),
                    Direction.vertical.spacer(1),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "${adsList[index].adId}",
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontFamily: hasStyle ? AppFonts.bold : null,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              Direction.horizontal.spacer(2),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      adsList[index].adSubject,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            fontFamily: hasStyle ? AppFonts.bold : null,
                          ),
                    ),
                    Direction.vertical.spacer(1.5),
                    Text(
                      "İlanın Bitiş Tarihi: ${adsList[index].adEndDate}",
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontFamily: hasStyle ? AppFonts.bold : null,
                          ),
                    ),
                    Direction.vertical.spacer(.5),
                    Row(
                      children: [
                        SizedBox(
                          width: 1.5.h,
                          height: 1.5.h,
                          child: Images.pin.pngWithScale,
                        ),
                        Direction.horizontal.spacer(1),
                        Text(
                          adsList[index].adCity +
                              "," +
                              adsList[index].adDistrict,
                          style:
                              Theme.of(context).textTheme.titleSmall?.copyWith(
                                    fontFamily: hasStyle ? AppFonts.bold : null,
                                  ),
                        ),
                      ],
                    ),
                    Direction.vertical.spacer(.5),
                    Row(
                      children: [
                        SizedBox(
                          width: 1.5.h,
                          height: 1.5.h,
                          child: Images.totalVisitors.pngWithScale,
                        ),
                        Direction.horizontal.spacer(1),
                        Text(
                          adsList[index].adTotalVisitors + " Gösterim",
                          style:
                              Theme.of(context).textTheme.titleSmall?.copyWith(
                                    fontFamily: hasStyle ? AppFonts.bold : null,
                                  ),
                        ),
                      ],
                    ),
                    Direction.vertical.spacer(.5),
                    Row(
                      children: [
                        SizedBox(
                          width: 1.5.h,
                          height: 1.5.h,
                          child: Images.star.pngWithScale,
                        ),
                        Direction.horizontal.spacer(1),
                        Text(
                          adsList[index].adTotalFav + " Favori",
                          style:
                              Theme.of(context).textTheme.titleSmall?.copyWith(
                                    fontFamily: hasStyle ? AppFonts.bold : null,
                                  ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        adsList[index].adPrice +
                            " " +
                            adsList[index].adCurrency,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: AppColors.ROMAN_EMPIRE_RED,
                              fontFamily: hasStyle ? AppFonts.bold : null,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
