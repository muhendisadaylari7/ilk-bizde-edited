// ignore_for_file: file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilkbizde/controllers/NetworkController.dart';
import 'package:ilkbizde/modules/CategoryResultPage/CategoryResultPageController.dart';
import 'package:ilkbizde/routes/app_pages.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/enum/images.dart';
import 'package:ilkbizde/shared/extensions/CacheSize.dart';
import 'package:ilkbizde/shared/extensions/ImageUrlType.dart';
import 'package:ilkbizde/shared/widgets/index.dart';
import 'package:sizer/sizer.dart';

class CategoryResultPage extends StatefulWidget {
  const CategoryResultPage({super.key});

  @override
  State<CategoryResultPage> createState() => _CategoryResultPageState();
}

class _CategoryResultPageState extends State<CategoryResultPage> {
  final CategoryResultPageController controller =
      Get.put(CategoryResultPageController());

  @override
  Widget build(BuildContext context) {
    Get.put(CategoryResultPageController());
    return Scaffold(
      appBar: CustomResultPageAppBar(
        totalAds: controller.totalAds,
        searchOnChanged: (p0) {
          controller.searchTextEditingController.addListener(() async {
            controller.searchQuery.value =
                controller.searchTextEditingController.text;
            await Future.delayed(
              const Duration(milliseconds: 700),
              () => controller.searchCategoryResults(),
            );
          });
        },
        searchTextEditingController: controller.searchTextEditingController,
      ),
      body: GetBuilder<NetworkController>(builder: (networkController) {
        if (networkController.connectionType.value == 0) {
          return const CustomNoInternetWidget();
        }
        return Obx(
          () => Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: CustomFilterWidget(
                      title: "Filtrele",
                      onTap: () => controller.createFilterBottomSheet(),
                    ),
                  ),
                  Expanded(
                    child: CustomSortWidget(
                      title: controller.selectedSortItem.value != 0
                          ? controller
                              .sortItems[controller.selectedSortItem.value - 1]
                          : AppStrings.sort,
                      controller: controller,
                    ),
                  ),
                ],
              ),
              Direction.vertical.spacer(1),
              Expanded(
                child: controller.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.ASHENVALE_NIGHTS,
                        ),
                      )
                    : ListView.separated(
                        controller: controller.scrollController,
                        itemCount: controller.searchCategoryAdsResult.length,
                        shrinkWrap: true,
                        separatorBuilder: (context, index) {
                          return CustomSeperatorWidget(
                            color: AppColors.STELLAR_BLUE.withOpacity(.5),
                          );
                        },
                        itemBuilder: (context, index) {
                          return CustomAdvertisementCard(
                            hasUrgent:
                                controller.searchCategoryAdsResult[index].acil,
                            hasPriceDrop: controller
                                .searchCategoryAdsResult[index].fiyatiDusen,
                            hasStyle: controller
                                .searchCategoryAdsResult[index].hasStyle,
                            title: controller
                                .searchCategoryAdsResult[index].adSubject,
                            onTap: () {
                              Get.toNamed(
                                Routes.ADVERTISEMENTDETAIL +
                                    controller
                                        .searchCategoryAdsResult[index].adId,
                                parameters: {
                                  "isUrgent": controller.parameters["isUrgent"]
                                      .toString(),
                                  "isLast24": controller.parameters["isLast24"]
                                      .toString(),
                                },
                              );
                            },
                            location:
                                "${controller.searchCategoryAdsResult[index].adCity}, ${controller.searchCategoryAdsResult[index].adDistrict}, ${controller.searchCategoryAdsResult[index].adMahalle}",
                            price:
                                "${controller.searchCategoryAdsResult[index].adPrice} ${controller.searchCategoryAdsResult[index].adCurrency}",
                            image: controller.searchCategoryAdsResult[index]
                                    .adPics.isNotEmpty
                                ? CachedNetworkImage(
                                    memCacheHeight: 9.5.h.cacheSize(context),
                                    imageUrl:
                                        ImageUrlTypeExtension.getImageType(
                                      controller
                                          .searchCategoryAdsResult[index].adPics
                                          .split(",")
                                          .first,
                                    ).ImageUrl(controller
                                            .searchCategoryAdsResult[index]
                                            .adPics),
                                  )
                                : Images.noImages.pngWithColor(
                                    Get.isDarkMode
                                        ? AppColors.WHITE
                                        : AppColors.BLACK,
                                  ),
                            isLoading: false.obs,
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
