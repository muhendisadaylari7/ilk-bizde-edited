// ignore_for_file: file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilkbizde/modules/SearchResultPage/SearchResultPageController.dart';
import 'package:ilkbizde/routes/app_pages.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/enum/images.dart';
import 'package:ilkbizde/shared/extensions/CacheSize.dart';
import 'package:ilkbizde/shared/extensions/ImageUrlType.dart';
import 'package:ilkbizde/shared/widgets/index.dart';
import 'package:sizer/sizer.dart';

class SearchResultPage extends StatefulWidget {
  const SearchResultPage({super.key});

  @override
  State<SearchResultPage> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  final SearchResultPageController controller =
      Get.put(SearchResultPageController());

  @override
  Widget build(BuildContext context) {
    Get.put(SearchResultPageController());
    return Scaffold(
      appBar: CustomResultPageAppBar(
        totalAds: controller.totalAds,
        searchOnChanged: (p0) {
          controller.searchTextEditingController.addListener(() async {
            controller.searchQuery.value =
                controller.searchTextEditingController.text;
            await Future.delayed(
              const Duration(milliseconds: 700),
              () => controller.searchResults(),
            );
          });
        },
        searchTextEditingController: controller.searchTextEditingController,
      ),
      backgroundColor:
          Get.isDarkMode ? AppColors.SOOTY : AppColors.ZHEN_ZHU_BAI_PEARL,
      body: Obx(
        () => Column(
          children: [
            CustomSortWidget(
              title: controller.selectedSortItem.value != 0
                  ? controller.sortItems[controller.selectedSortItem.value - 1]
                  : AppStrings.sort,
              controller: controller,
            ),
            Direction.vertical.spacer(1),
            Expanded(
              child: NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  if (notification is ScrollUpdateNotification) {
                    controller.onScroll();
                    return false;
                  }
                  return false;
                },
                child: ListView.separated(
                  padding: EdgeInsets.only(bottom: 6.h),
                  controller: controller.scrollController,
                  shrinkWrap: true,
                  itemCount: controller.searchedAdsResult.length,
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: AppColors.STELLAR_BLUE.withOpacity(.5),
                      height: 0,
                    );
                  },
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        CustomAdvertisementCard(
                          hasUrgent: controller.searchedAdsResult[index].acil,
                          hasPriceDrop:
                              controller.searchedAdsResult[index].fiyatiDusen,
                          hasStyle:
                              controller.searchedAdsResult[index].hasStyle,
                          title: controller.searchedAdsResult[index].adSubject,
                          onTap: () {
                            Get.toNamed(
                              Routes.ADVERTISEMENTDETAIL +
                                  controller.searchedAdsResult[index].adId,
                            );
                          },
                          location:
                              "${controller.searchedAdsResult[index].adCity}, ${controller.searchedAdsResult[index].adDistrict}",
                          price:
                              "${controller.searchedAdsResult[index].adPrice} ${controller.searchedAdsResult[index].adCurrency}",
                          image: controller
                                  .searchedAdsResult[index].adPics.isNotEmpty
                              ? CachedNetworkImage(
                                  memCacheHeight: 9.5.h.cacheSize(context),
                                  imageUrl: ImageUrlTypeExtension.getImageType(
                                          controller
                                              .searchedAdsResult[index].adPics
                                              .split(",")
                                              .first)
                                      .ImageUrl(controller
                                          .searchedAdsResult[index].adPics),
                                )
                              : Images.noImages.pngWithColor(
                                  Get.isDarkMode
                                      ? AppColors.WHITE
                                      : AppColors.BLACK,
                                ),
                          isLoading: false.obs,
                        ),
                        Obx(
                          () => controller.searchedAdsResult.length - 1 ==
                                      index &&
                                  controller.isLoading.value
                              ? Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.only(top: 2.h),
                                  child: const CircularProgressIndicator(
                                    color: AppColors.ASHENVALE_NIGHTS,
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
