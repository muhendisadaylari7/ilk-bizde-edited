// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:ilkbizde/data/network/api/Last24HourApi.dart';
import 'package:ilkbizde/data/network/api/UrgentCategoryApi.dart';
import 'package:ilkbizde/modules/SelectCategoryPage/SelectCategoryPageController.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/widgets/index.dart';
import 'package:sizer/sizer.dart';

class SelectCategoryPage extends StatefulWidget {
  const SelectCategoryPage({super.key});

  @override
  State<SelectCategoryPage> createState() => _SelectCategoryPageState();
}

class _SelectCategoryPageState extends State<SelectCategoryPage> {
  final SelectCategoryPageController controller =
      Get.put(SelectCategoryPageController());

  @override
  Widget build(BuildContext context) {
    Get.put(SelectCategoryPageController());
    return Scaffold(
      appBar: CustomMyAccountItemAppBar(
          title: "Kategori Seçimi",
          onBackButtonPressed: () {
            if (controller.currenPageIndex.value == 0) {
              Get.back();
            } else {
              controller.totalSubCategoriesList.removeRange(
                controller.currenPageIndex.value,
                controller.totalSubCategoriesList.length,
              );
            }
          }),
      body: WillPopScope(
        onWillPop: () async {
          if (controller.currenPageIndex.value == 0) {
            return true;
          } else {
            controller.totalSubCategoriesList.removeRange(
              controller.currenPageIndex.value,
              controller.totalSubCategoriesList.length,
            );
            return false;
          }
        },
        child: Obx(
          () => controller.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.ASHENVALE_NIGHTS,
                  ),
                )
              : PageView.builder(
                  itemCount: controller.totalSubCategoriesList.length,
                  controller: PageController(
                    initialPage: controller.totalSubCategoriesList.length - 1,
                  ),
                  onPageChanged: (value) {
                    controller.currenPageIndex.value = value;
                  },
                  itemBuilder: (context, pageIndex) {
                    controller.currenPageIndex.value = pageIndex;
                    return ListView.separated(
                      physics: const ClampingScrollPhysics(),
                      padding: EdgeInsets.only(bottom: 6.h),
                      shrinkWrap: true,
                      itemCount:
                          controller.totalSubCategoriesList[pageIndex].length,
                      separatorBuilder: (context, index) =>
                          const CustomSeperatorWidget(
                        color: AppColors.BRUSHED_METAL,
                      ),
                      itemBuilder: (context, index) {
                        return _CustomSubCategoryListItem(
                          controller: controller,
                          index: index,
                          pageIndex: pageIndex,
                          onTap: () async {
                            final isRedirectOrError = await controller
                                .redirectToCategoryResult(index, pageIndex);
                            if (isRedirectOrError) return;
                            if (controller.parameters["isUrgent"] == "1") {
                              controller.getUrgentOrLast24HourSubCategories(
                                subCategoriesApi: UrgentCategoryApi(),
                                parameter: "isUrgent",
                                categoryId: controller
                                    .totalSubCategoriesList[pageIndex][index]
                                    .categoryId,
                                categoryName: controller
                                    .totalSubCategoriesList[pageIndex][index]
                                    .categoryName,
                                categoryCount: controller
                                        .totalSubCategoriesList[pageIndex]
                                            [index]
                                        .categoryAdCount ??
                                    "",
                                pageIndex: pageIndex + 1,
                                index: index,
                              );
                            } else if (controller.parameters["isLast24"] ==
                                "1") {
                              controller.getUrgentOrLast24HourSubCategories(
                                subCategoriesApi: Last24HourApi(),
                                parameter: "isLast24",
                                categoryId: controller
                                    .totalSubCategoriesList[pageIndex][index]
                                    .categoryId,
                                categoryName: controller
                                    .totalSubCategoriesList[pageIndex][index]
                                    .categoryName,
                                categoryCount: controller
                                        .totalSubCategoriesList[pageIndex]
                                            [index]
                                        .categoryAdCount ??
                                    "",
                                pageIndex: pageIndex + 1,
                                index: index,
                              );
                            } else {
                              controller.getSubCategories(
                                categoryId: controller
                                    .totalSubCategoriesList[pageIndex][index]
                                    .categoryId,
                                categoryName: controller
                                    .totalSubCategoriesList[pageIndex][index]
                                    .categoryName,
                                categoryCount: controller
                                        .totalSubCategoriesList[pageIndex]
                                            [index]
                                        .categoryAdCount ??
                                    "",
                                pageIndex: pageIndex + 1,
                                index: index,
                              );
                            }
                          },
                        );
                      },
                    );
                  },
                ),
        ),
      ),
    );
  }
}

class _CustomSubCategoryListItem extends StatelessWidget {
  final SelectCategoryPageController controller;
  final int index;
  final int pageIndex;
  final void Function() onTap;
  const _CustomSubCategoryListItem({
    required this.controller,
    required this.index,
    required this.onTap,
    required this.pageIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.5.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                controller
                    .totalSubCategoriesList[pageIndex][index].categoryName,
                style: index == 0
                    ? Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Get.isDarkMode
                              ? AppColors.BRANDEIS_BLUE
                              : AppColors.ASHENVALE_NIGHTS,
                          fontFamily: AppFonts.medium,
                        )
                    : Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Get.isDarkMode ? null : AppColors.CORBEAU,
                        ),
              ),
            ),
            Direction.horizontal.spacer(3),
            Text(
              controller.totalSubCategoriesList[pageIndex][index]
                      .categoryAdCount ??
                  "",
              style: index == 0
                  ? Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Get.isDarkMode
                            ? AppColors.BRANDEIS_BLUE
                            : AppColors.ASHENVALE_NIGHTS,
                        fontFamily: AppFonts.medium,
                      )
                  : Theme.of(context).textTheme.labelSmall?.copyWith(
                        fontSize: 9.sp,
                        color: AppColors.BRUSHED_METAL,
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
