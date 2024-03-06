// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilkbizde/modules/MyStoreInfo/MyStoreInfoController.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/widgets/index.dart';
import 'package:sizer/sizer.dart';

class MyStoreInfo extends StatefulWidget {
  const MyStoreInfo({super.key});

  @override
  State<MyStoreInfo> createState() => _MyStoreInfoState();
}

class _MyStoreInfoState extends State<MyStoreInfo> {
  final MyStoreInfoController controller = Get.put(MyStoreInfoController());

  @override
  Widget build(BuildContext context) {
    Get.put(MyStoreInfoController());
    return Scaffold(
      appBar: const CustomMyAccountItemAppBar(title: 'Mağazam'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
        child: Column(
          children: [
            Expanded(
              child: Obx(
                () => controller.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.ASHENVALE_NIGHTS,
                        ),
                      )
                    : ListView.separated(
                        shrinkWrap: true,
                        itemCount: controller
                            .categories.first.magazaKategorileri.length,
                        separatorBuilder: (context, index) =>
                            Direction.vertical.spacer(2),
                        itemBuilder: (context, index) {
                          return CustomMarketCategoryCard(
                            index: index,
                            controller: controller,
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

enum MarketCategory { all, realEstate, vehicle }

extension MarketCategoryExtension on MarketCategory {
  IconData get name {
    switch (this) {
      case MarketCategory.all:
        return Icons.rocket;
      case MarketCategory.realEstate:
        return Icons.home;
      case MarketCategory.vehicle:
        return Icons.drive_eta;
      default:
        return Icons.abc;
    }
  }
}

class CustomMarketCategoryCard extends StatelessWidget {
  final int index;
  final MyStoreInfoController controller;
  const CustomMarketCategoryCard({
    super.key,
    required this.index,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.SHY_MOMENT.withOpacity(.1),
        border:
            Border.all(color: AppColors.SHY_MOMENT.withOpacity(.3), width: 1),
        borderRadius: AppBorderRadius.inputRadius,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 5.w,
        vertical: 2.h,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RotationTransition(
            turns: MarketCategory.values[index] == MarketCategory.all
                ? const AlwaysStoppedAnimation(45 / 360)
                : const AlwaysStoppedAnimation(0 / 360),
            child: Icon(
              MarketCategory.values[index].name,
              color: AppColors.ASHENVALE_NIGHTS,
              size: 20.sp,
            ),
          ),
          Direction.horizontal.spacer(1),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // BAŞLIK
                Text(
                  controller
                      .categories.first.magazaKategorileri[index].filterName,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontFamily: AppFonts.medium,
                      color: AppColors.ASHENVALE_NIGHTS),
                ),
                Direction.vertical.spacer(1),
                // ALT BAŞLIK
                CustomAltTextRich(
                  text: "Alt Kategoriler: ",
                  subtext: controller
                      .categories.first.magazaKategorileri[index].fieldAltCat,
                ),
                Direction.vertical.spacer(1),
                // DROPDOWN
                CustomDropdownFieldWithList(
                  value: controller
                      .categories.first.magazaKategorileri[index].filterChoises
                      .split("||")[0],
                  items: controller
                      .categories.first.magazaKategorileri[index].filterChoises
                      .split("||")
                      .map<DropdownMenuItem<String>>(
                        (String value) => DropdownMenuItem(
                          value: value,
                          onTap: () {
                            controller.selectedMarketCategory.value = value;
                          },
                          child: Text(
                            value,
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ),
                      )
                      .toList(),
                ),
                Direction.vertical.spacer(2),
                // SELECT BUTTON
                SizedBox(
                  height: 5.5.h,
                  child: CustomButton(
                    title: "Seç",
                    bg: AppColors.ALOHA,
                    onTap: () {
                      Get.bottomSheet(
                        CustomMarketInfosBottomSheetWidget(
                          controller: controller,
                          buttonTitle: "Oluştur",
                          onTap: () => controller.handleCreateMarket(
                            categoryId: controller.categories.first
                                .magazaKategorileri[index].fieldCat
                                .toString(),
                            duration: controller.categories.first
                                .magazaKategorileri[index].fieldDuration,
                          ),
                        ),
                        isScrollControlled: true,
                      );
                    },
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
