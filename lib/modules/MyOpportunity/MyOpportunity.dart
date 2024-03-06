import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilkbizde/modules/MyOpportunity/MyOpportunityController.dart';
import 'package:ilkbizde/modules/MyOpportunity/widgets/CustomGradientPainter.dart';
import 'package:ilkbizde/modules/MyOpportunity/widgets/CustomMissionTextWidgetFromMissionType.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/enum/GiftDopingType.dart';
import 'package:ilkbizde/shared/helpers/getDopingActiveOrUsed.dart';
import 'package:ilkbizde/shared/helpers/getMissionType.dart';
import 'package:ilkbizde/shared/widgets/index.dart';
import 'package:sizer/sizer.dart';

class MyOpportunity extends StatefulWidget {
  const MyOpportunity({super.key});

  @override
  State<MyOpportunity> createState() => _MyOpportunityState();
}

class _MyOpportunityState extends State<MyOpportunity> {
  final MyOpportunityController controller = Get.put(MyOpportunityController());

  @override
  Widget build(BuildContext context) {
    Get.put(MyOpportunityController());
    return Scaffold(
      appBar: const CustomMyAccountItemAppBar(title: "Fırsatlarım"),
      backgroundColor:
          Get.isDarkMode ? AppColors.SOOTY : AppColors.ZHEN_ZHU_BAI_PEARL,
      body: Obx(
        () => controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(
                  color: AppColors.ASHENVALE_NIGHTS,
                ),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: AppPaddings.generalPadding
                      .copyWith(top: 1.h, bottom: 2.h),
                  child: Column(
                    children: [
                      // HESAP BİLGİLERİ
                      CustomAccountNameAndAccountTypeWidget(
                        controller: controller.myAccountController,
                      ),
                      Direction.vertical.spacer(2),
                      controller.giftAndMissionInfos.first.hediyeler!.isEmpty
                          ? const SizedBox.shrink()
                          : Text(
                              "KAZANILAN DOPİNGLER",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                    color: AppColors.ASHENVALE_NIGHTS,
                                    fontFamily: AppFonts.semiBold,
                                  ),
                            ),
                      Direction.vertical.spacer(.5),
                      // KAZANILAN DOPİNGLER
                      controller.giftAndMissionInfos.first.hediyeler!.isEmpty
                          ? const SizedBox.shrink()
                          : buildEarnedDopings(),
                      Direction.vertical.spacer(2),
                      Text(
                        "DOPİNG ÖDEMELERİ",
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: Get.isDarkMode
                                  ? AppColors.WHITE
                                  : AppColors.CORBEAU,
                              fontFamily: AppFonts.semiBold,
                            ),
                      ),
                      Direction.vertical.spacer(1),
                      Text(
                        "İlkbizde uygulamasında harcadıkça kazan.",
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: Get.isDarkMode
                                  ? AppColors.WHITE.withOpacity(.6)
                                  : AppColors.CORBEAU.withOpacity(.6),
                            ),
                      ),
                      Direction.vertical.spacer(2),
                      // HARCANAN BAKİYE
                      CustomPaint(
                        painter: CustomGradientPainter(
                          strokeWidth: 5,
                          radius: 8,
                          gradient: const LinearGradient(
                            colors: [
                              AppColors.BALLET_CREAM,
                              AppColors.JELLYFISH_STING,
                            ],
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 100.w,
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(
                                horizontal: 3.w,
                                vertical: 1.h,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: AppBorderRadius.inputRadius,
                                gradient: const LinearGradient(
                                  colors: [
                                    AppColors.BALLET_CREAM,
                                    AppColors.JELLYFISH_STING,
                                  ],
                                ),
                              ),
                              child: const Text(
                                "Harcanan Bakiye",
                                style: TextStyle(
                                  fontFamily: AppFonts.medium,
                                  fontSize: 20,
                                  color: AppColors.WHITE,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 3.w,
                                vertical: 1.h,
                              ),
                              child: Text(
                                controller
                                    .giftAndMissionInfos.first.toplamHarcama,
                                style: const TextStyle(
                                  fontFamily: AppFonts.semiBold,
                                  fontSize: 48,
                                  color: AppColors.JELLYFISH_STING,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Direction.vertical.spacer(2),
                      // GÖREVLER
                      buildMissionList()
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget buildMissionList() {
    return SizedBox(
      width: 100.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Görevler:",
            style: Theme.of(Get.context!).textTheme.labelSmall?.copyWith(
                  color: Get.isDarkMode ? AppColors.WHITE : AppColors.CORBEAU,
                  fontFamily: AppFonts.semiBold,
                ),
          ),
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              return CustomMissionTextWidgetFromMissionType(
                missionType: getMissionType(
                  controller
                      .giftAndMissionInfos.first.gorevler[index].gorevlerTuru,
                ),
                doping: controller
                    .giftAndMissionInfos.first.gorevler[index].gorevDopingTuru,
                price: controller
                    .giftAndMissionInfos.first.gorevler[index].gorevDopingAralk,
              );
            },
            separatorBuilder: (context, index) =>
                CustomSeperatorWidget(color: AppColors.BLACK.withOpacity(.1)),
            itemCount: controller.giftAndMissionInfos.first.gorevler.length,
            shrinkWrap: true,
          ),
        ],
      ),
    );
  }

  ListView buildEarnedDopings() {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        return Container(
          width: 100.w,
          decoration: BoxDecoration(
            color: Get.isDarkMode ? AppColors.BLACK_WASH : AppColors.WHITE,
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 4),
                blurRadius: 4,
                spreadRadius: 0,
                color: AppColors.BLACK.withOpacity(.25),
              )
            ],
            border: Border.all(
              color: Get.isDarkMode
                  ? AppColors.COLD_MORNING.withOpacity(.1)
                  : AppColors.COLD_MORNING,
              width: 1,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 3.w,
              vertical: 1.h,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${index + 1}.${controller.giftAndMissionInfos.first.hediyeler?[index].dopingTuru}",
                ),
                CustomActiveOrUsedWidget(
                  giftDopingType: stringToGiftDopingType(
                    controller.giftAndMissionInfos.first.hediyeler![index]
                        .dopingDurumu,
                  ),
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => CustomSeperatorWidget(
        color: AppColors.BLACK.withOpacity(.1),
      ),
      itemCount: controller.giftAndMissionInfos.first.hediyeler!.length,
      shrinkWrap: true,
    );
  }
}

class CustomActiveOrUsedWidget extends StatelessWidget {
  final GiftDopingType giftDopingType;
  const CustomActiveOrUsedWidget({super.key, required this.giftDopingType});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 2.w,
        vertical: .5.h,
      ),
      decoration: BoxDecoration(
        borderRadius: AppBorderRadius.inputRadius,
        color: giftDopingType == GiftDopingType.active
            ? AppColors.GREEN_WRASSE
            : AppColors.RED,
      ),
      child: Text(
        giftDopingType.getGiftDopingType,
        style: Theme.of(context)
            .textTheme
            .titleMedium
            ?.copyWith(color: AppColors.WHITE),
      ),
    );
  }
}
