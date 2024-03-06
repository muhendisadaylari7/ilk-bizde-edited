// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:ilkbizde/controllers/NetworkController.dart';
import 'package:ilkbizde/modules/AllDailyOpportunity/AllDailyOpportunityController.dart';
import 'package:ilkbizde/routes/app_pages.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/enum/images.dart';
import 'package:ilkbizde/shared/widgets/index.dart';
import 'package:sizer/sizer.dart';

class AllDailyOpportunity extends StatefulWidget {
  const AllDailyOpportunity({super.key});

  @override
  State<AllDailyOpportunity> createState() => _AllDailyOpportunityState();
}

class _AllDailyOpportunityState extends State<AllDailyOpportunity> {
  final AllDailyOpportunityController controller =
      Get.put(AllDailyOpportunityController());

  @override
  Widget build(BuildContext context) {
    Get.put(AllDailyOpportunityController());
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 16.w,
        leading: Container(
          margin: EdgeInsets.only(left: 5.7.w),
          child: Bounceable(
              onTap: () => Get.back(),
              child: Images.homeAppBarLeadingIcon.pngWithScale),
        ),
        title: Text(
          "Günün Fırsatı",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: GetBuilder<NetworkController>(builder: (networkController) {
        if (networkController.connectionType.value == 0) {
          return const CustomNoInternetWidget();
        }
        return Obx(
          () => ListView.separated(
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(
              horizontal: 4.w,
              vertical: 1.h,
            ).copyWith(
              bottom: 2.h,
            ),
            itemCount:
                controller.homeController.dailyOpportunityAdvertisements.length,
            separatorBuilder: (context, index) => Direction.vertical.spacer(1),
            itemBuilder: (context, index) {
              return CustomDailyOpportunityAdsCard(
                onTap: () {
                  Get.toNamed(
                    Routes.ADVERTISEMENTDETAIL +
                        controller.homeController
                            .dailyOpportunityAdvertisements[index].adId,
                    parameters: {
                      "dailyOpportunity": "1",
                    },
                  );
                },
                isLoading: controller.homeController.isLoading,
                controller: controller.homeController,
                index: index,
                hasButton: true,
              );
            },
          ),
        );
      }),
    );
  }
}
