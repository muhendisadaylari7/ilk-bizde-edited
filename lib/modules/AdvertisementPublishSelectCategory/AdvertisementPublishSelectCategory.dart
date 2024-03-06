// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:ilkbizde/controllers/NetworkController.dart';
import 'package:ilkbizde/modules/AdvertisementPublishSelectCategory/AdvertisementPublishSelectCategoryController.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/widgets/index.dart';
import 'package:sizer/sizer.dart';

class AdvertisementPublishSelectCategory extends StatefulWidget {
  const AdvertisementPublishSelectCategory({super.key});

  @override
  State<AdvertisementPublishSelectCategory> createState() =>
      _AdvertisementPublishSelectCategoryState();
}

class _AdvertisementPublishSelectCategoryState
    extends State<AdvertisementPublishSelectCategory> {
  final AdvertisementPublishSelectCategoryController controller =
      Get.put(AdvertisementPublishSelectCategoryController());

  @override
  Widget build(BuildContext context) {
    Get.put(AdvertisementPublishSelectCategoryController());
    return Scaffold(
      body: GetBuilder<NetworkController>(
        builder: (networkController) {
          if (networkController.connectionType.value == 0) {
            return const CustomNoInternetWidget();
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.5.h),
                child: const Text(
                  "Adım Adım Kategori Seçimi",
                  style: TextStyle(
                    fontFamily: AppFonts.medium,
                    fontSize: 14,
                    color: AppColors.SILVER,
                  ),
                ),
              ),
              const CustomSeperatorWidget(color: AppColors.SHY_MOMENT),
              Expanded(
                child: Obx(
                  () => controller.isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.ASHENVALE_NIGHTS,
                          ),
                        )
                      : PageView.builder(
                          itemCount: controller.subCategories.length,
                          controller: PageController(
                            initialPage: controller.subCategories.length - 1,
                          ),
                          onPageChanged: (value) {
                            controller.currenPageIndex.value = value;
                          },
                          itemBuilder: (context, pageIndex) {
                            controller.currenPageIndex.value = pageIndex;
                            return ListView.builder(
                              physics: const ClampingScrollPhysics(),
                              padding: EdgeInsets.only(bottom: 6.h),
                              shrinkWrap: true,
                              itemCount:
                                  controller.subCategories[pageIndex].length,
                              itemBuilder: (context, index) {
                                return Bounceable(
                                  onTap: () {
                                    controller.createAds(
                                      categoryId: controller
                                          .subCategories[pageIndex][index]
                                          .categoryId,
                                      pageIndex: pageIndex + 1,
                                      index: index,
                                    );
                                    if (controller.selectedCategories.value
                                        .split(",")[pageIndex]
                                        .isNotEmpty) {
                                      List<String> categoryIds = controller
                                          .selectedCategories.value
                                          .split(",");
                                      categoryIds.removeRange(
                                          pageIndex, categoryIds.length);
                                      categoryIds.add(
                                          "${controller.subCategories[pageIndex][index].categoryId},");
                                      controller.selectedCategories.value =
                                          categoryIds.join(",");
                                    } else if (controller
                                        .selectedCategories.value
                                        .split(",")[pageIndex]
                                        .isEmpty) {
                                      controller.selectedCategories.value +=
                                          "${controller.subCategories[pageIndex][index].categoryId},";
                                    }
                                  },
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.transparent,
                                      border: Border(
                                        bottom: BorderSide(
                                          color: AppColors.SHY_MOMENT,
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 5.w, vertical: 1.5.h),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            controller
                                                .subCategories[pageIndex][index]
                                                .categoryName,
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall
                                                ?.copyWith(
                                                  color: AppColors.CORBEAU,
                                                ),
                                          ),
                                        ),
                                        Direction.horizontal.spacer(3),
                                        const Icon(
                                          Icons.arrow_forward,
                                          color: AppColors.BRUSHED_METAL,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
