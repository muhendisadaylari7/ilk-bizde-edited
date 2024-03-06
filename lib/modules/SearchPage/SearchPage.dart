// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:ilkbizde/data/model/CategoriesResponseModel.dart';
import 'package:ilkbizde/modules/Favorites/index.dart';
import 'package:ilkbizde/modules/SearchPage/SearchPageController.dart';
import 'package:ilkbizde/routes/app_pages.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/enum/images.dart';
import 'package:ilkbizde/shared/widgets/index.dart';
import 'package:sizer/sizer.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final SearchPageController controller = Get.put(SearchPageController());

  @override
  Widget build(BuildContext context) {
    Get.put(SearchPageController());
    return Scaffold(
      appBar: CustomMyAccountItemAppBar(title: AppStrings.search),
      backgroundColor:
          Get.isDarkMode ? AppColors.SOOTY : AppColors.ZHEN_ZHU_BAI_PEARL,
      body: Column(
        children: [
          _CustomSearchFeature(controller: controller),
          Direction.vertical.spacer(2),
          Expanded(
            child: Obx(
              () => controller.isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.ASHENVALE_NIGHTS,
                      ),
                    )
                  : controller.resultList.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Images.noSearch.pngWithScale,
                            Direction.vertical.spacer(1),
                            Text(
                              AppStrings.noSearch,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                    color: Get.isDarkMode
                                        ? null
                                        : AppColors.ASHENVALE_NIGHTS,
                                  ),
                            ),
                          ],
                        )
                      : SingleChildScrollView(
                          physics: const ClampingScrollPhysics(),
                          padding: EdgeInsets.only(bottom: 6.h),
                          child: Column(
                            children: [
                              controller.resultList[0].ads != null
                                  ? Container(
                                      margin: EdgeInsets.only(bottom: 2.h),
                                      padding: EdgeInsets.symmetric(
                                        vertical: 2.h,
                                      ),
                                      color: Get.isDarkMode
                                          ? AppColors.BLACK_WASH
                                          : AppColors.WHITE,
                                      child: Column(
                                        children: [
                                          const CustomSearchResultTitleWidget(
                                            text: AppStrings.adsTitle,
                                          ),
                                          Direction.vertical.spacer(1),
                                          // İLAN SONUÇLARI LİSTESİ
                                          CustomAdsSearchResultWidget(
                                            controller: controller,
                                          ),
                                        ],
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                              controller.resultList[0].cats != null
                                  ? Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 2.h,
                                      ),
                                      color: Get.isDarkMode
                                          ? AppColors.BLACK_WASH
                                          : AppColors.WHITE,
                                      child: Column(
                                        children: [
                                          const CustomSearchResultTitleWidget(
                                            text: AppStrings.categoriesTitle,
                                          ),
                                          // KATEGORİ SONUÇLARI LİSTESİ
                                          CustomAdsCategorySearchResultWidget(
                                            controller: controller,
                                          ),
                                        ],
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                            ],
                          ),
                        ),
            ),
          )
        ],
      ),
    );
  }
}

// ARAMA İŞLEMİNİ YAPAN WIDGET
class _CustomSearchFeature extends StatelessWidget {
  final SearchPageController controller;
  const _CustomSearchFeature({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: true,
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      controller: controller.searchController,
      onChanged: (value) {
        controller.searchController.addListener(() async {
          controller.searchQuery.value = controller.searchController.text;
          await Future.delayed(
            const Duration(milliseconds: 700),
            () => controller.searchSuggest(),
          );
        });
      },
      cursorColor: AppColors.BLACK,
      style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: Get.isDarkMode ? null : AppColors.OBSIDIAN_SHARD,
          ),
      onFieldSubmitted: (value) => controller.redirectToResult(),
      decoration: InputDecoration(
        hintText: AppStrings.searchPageInputHintText,
        hintStyle: Theme.of(context).textTheme.labelMedium,
        suffixIcon: Bounceable(
          onTap: () => controller.redirectToResult(),
          child: const CustomImageAsset(path: Images.inputSearch),
        ),
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
      ),
    );
  }
}

// KATEGORİ SONUÇLARI LİSTESİ
class CustomAdsCategorySearchResultWidget extends StatelessWidget {
  final SearchPageController controller;
  const CustomAdsCategorySearchResultWidget({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.resultList[0].cats!.length,
      separatorBuilder: (context, index) =>
          const CustomSeperatorWidget(color: AppColors.ZHEN_ZHU_BAI_PEARL),
      itemBuilder: (context, index) {
        if (controller.resultList[0].cats == null) {
          return const SizedBox.shrink();
        }
        return Bounceable(
          onTap: () {
            final CategoriesResponseModel categoriesResponseModel =
                CategoriesResponseModel(
              categoryId: controller.resultList[0].cats![index].categoryId,
              categoryName: controller.resultList[0].cats![index].text,
              categoryAdCount:
                  controller.resultList[0].cats![index].categoryAdCount,
            );
            Get.toNamed(
              Routes.SELECTCATEGORYPAGE,
              parameters: categoriesResponseModel.toJson(),
            );
          },
          child: Container(
            color: Colors.transparent,
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.resultList[0].cats![index].text,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        fontFamily: AppFonts.light,
                        color: Get.isDarkMode ? null : AppColors.CORBEAU,
                      ),
                ),
                Text(
                  controller.resultList[0].cats![index].sub,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        fontFamily: AppFonts.light,
                        color: AppColors.BLUE_RIBBON,
                      ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// SONUÇ BAŞLIKLARI
class CustomSearchResultTitleWidget extends StatelessWidget {
  final String text;
  const CustomSearchResultTitleWidget({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.labelSmall?.copyWith(
            fontFamily: AppFonts.medium,
            color: Get.isDarkMode ? null : AppColors.CORBEAU,
          ),
    );
  }
}

// İLAN SONUÇLARI LİSTESİ
class CustomAdsSearchResultWidget extends StatelessWidget {
  final SearchPageController controller;
  const CustomAdsSearchResultWidget({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      separatorBuilder: (context, index) =>
          const CustomSeperatorWidget(color: AppColors.ZHEN_ZHU_BAI_PEARL),
      itemCount: controller.resultList[0].ads!.length,
      itemBuilder: (context, index) {
        if (controller.resultList[0].ads == null) {
          return const SizedBox.shrink();
        }
        return Bounceable(
          onTap: () {
            Get.toNamed(
              Routes.ADVERTISEMENTDETAIL +
                  controller.resultList[0].ads![index].id,
            );
            // controller.searchQuery.value =
            //     controller.resultList[0].ads![index].text;
            // controller.redirectToResult();
          },
          child: Container(
            color: Colors.transparent,
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
            child: Text(
              controller.resultList[0].ads![index].text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontFamily: AppFonts.light,
                    color: Get.isDarkMode ? null : AppColors.CORBEAU,
                  ),
            ),
          ),
        );
      },
    );
  }
}
