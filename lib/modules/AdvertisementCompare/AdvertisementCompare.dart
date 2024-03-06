// ignore_for_file: file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:ilkbizde/controllers/NetworkController.dart';
import 'package:ilkbizde/modules/AdvertisementCompare/index.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/enum/images.dart';
import 'package:ilkbizde/shared/extensions/ImageUrlType.dart';
import 'package:ilkbizde/shared/widgets/index.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class AdvertisementCompare extends StatefulWidget {
  const AdvertisementCompare({super.key});

  @override
  State<AdvertisementCompare> createState() => _AdvertisementCompareState();
}

class _AdvertisementCompareState extends State<AdvertisementCompare> {
  final AdvertisementCompareController controller =
      Get.put(AdvertisementCompareController());

  @override
  Widget build(BuildContext context) {
    Get.put(AdvertisementCompareController());
    return Scaffold(
      appBar: const CustomMyAccountItemAppBar(title: "Karşılaştırma"),
      body: GetBuilder<NetworkController>(builder: (networkController) {
        if (networkController.connectionType.value == 0) {
          return const CustomNoInternetWidget();
        }
        return Obx(
          () => PageView.builder(
            padEnds: false,
            controller: PageController(
              viewportFraction: controller.allAds.length == 1 ? 1 : .5,
            ),
            itemCount: controller.allAds.length,
            itemBuilder: (context, pageIndex) {
              return SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(
                        color: AppColors.SILVER,
                        width: .2.w,
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10.h,
                        child: CachedNetworkImage(
                          imageUrl: ImageUrlTypeExtension.getImageType(
                                  controller.allAds[pageIndex].adPic
                                      .split(",")
                                      .first)
                              .ImageUrl(controller.allAds[pageIndex].adPic),
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) =>
                              Images.noImages.pngWithColor(
                            Get.isDarkMode ? AppColors.WHITE : AppColors.BLACK,
                          ),
                        ),
                      ),
                      Direction.vertical.spacer(2),
                      SizedBox(
                        height: 5.h,
                        child: Text(
                          controller.allAds[pageIndex].adSubject,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: AppColors.BRANDEIS_BLUE,
                                  ),
                        ),
                      ),
                      Direction.vertical.spacer(2),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Text(
                                controller.allAds[pageIndex].adInfo[index].key
                                    .toString(),
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall
                                    ?.copyWith(
                                      color: AppColors.BLACK,
                                    ),
                              ),
                              controller.allAds[pageIndex].adInfo[index].key
                                      .toString()
                                      .contains("Parsel Sorgu")
                                  ? Bounceable(
                                      onTap: () async {
                                        if (await canLaunchUrl(
                                          Uri.parse(
                                            controller.allAds[pageIndex]
                                                .adInfo[index].value
                                                .toString(),
                                          ),
                                        )) {
                                          await launchUrl(
                                            Uri.parse(
                                              controller.allAds[pageIndex]
                                                  .adInfo[index].value
                                                  .toString(),
                                            ),
                                          );
                                        } else {
                                          throw 'Could not launch';
                                        }
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 3.w, vertical: .5.h),
                                        decoration: BoxDecoration(
                                          color: AppColors.CLEAR_CHILL,
                                          borderRadius:
                                              AppBorderRadius.inputRadius,
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
                                      controller
                                          .allAds[pageIndex].adInfo[index].value
                                          .toString(),
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall
                                          ?.copyWith(
                                            color: AppColors.STEEL,
                                          ),
                                    ),
                            ],
                          );
                        },
                        separatorBuilder: (context, index) =>
                            Direction.vertical.spacer(2),
                        itemCount: controller.allAds[pageIndex].adInfo.length,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
