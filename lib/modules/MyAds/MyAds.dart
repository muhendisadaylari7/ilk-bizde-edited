// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilkbizde/controllers/NetworkController.dart';
import 'package:ilkbizde/modules/MyAds/MyAdsController.dart';
import 'package:ilkbizde/routes/app_pages.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/widgets/index.dart';
import 'package:sizer/sizer.dart';
import 'package:ilkbizde/shared/enum/myAdsType.dart';

class MyAds extends StatefulWidget {
  const MyAds({super.key});

  @override
  State<MyAds> createState() => _MyAdsState();
}

class _MyAdsState extends State<MyAds> {
  final MyAdsController controller = Get.put(MyAdsController());

  @override
  Widget build(BuildContext context) {
    Get.put(MyAdsController());
    return Scaffold(
      appBar: CustomMyAccountItemAppBar(
        title: MyAdsTypeExtension(controller.args[0]).name,
      ),
      backgroundColor: Get.isDarkMode ? null : AppColors.ZHEN_ZHU_BAI_PEARL,
      body: GetBuilder<NetworkController>(builder: (networkController) {
        if (networkController.connectionType.value == 0) {
          return const CustomNoInternetWidget();
        }
        return Obx(
          () => controller.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.ASHENVALE_NIGHTS,
                  ),
                )
              : controller.myAdsList.isEmpty
                  ? Center(
                      child: Text(
                        "İLAN BULUNMAMAKTADIR!",
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    )
                  : ListView.separated(
                      shrinkWrap: true,
                      itemCount: controller.myAdsList.length,
                      padding: EdgeInsets.symmetric(vertical: 2.h)
                          .copyWith(bottom: 6.h),
                      separatorBuilder: (context, index) =>
                          Direction.vertical.spacer(1),
                      itemBuilder: (context, index) {
                        return CustomMyAdsCard(
                          hasUrgent: controller.myAdsList[index].acil,
                          hasPriceDrop: controller.myAdsList[index].fiyatiDusen,
                          hasStyle: controller.myAdsList[index].hasStyle,
                          onTap: () {
                            Get.toNamed(
                              Routes.MYADSDETAIL,
                              parameters: {
                                "adId": controller.myAdsList[index].adId,
                                "index": index.toString(),
                              },
                              arguments: [
                                controller.args[0],
                              ],
                            );
                          },
                          adsList: controller.myAdsList,
                          index: index,
                        );
                      },
                    ),
        );
      }),
    );
  }
}
