// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilkbizde/modules/LeaseAgreementsDetail/LeaseAgreementsDetailController.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/widgets/index.dart';
import 'package:sizer/sizer.dart';

class LeaseAgreementsDetail extends StatefulWidget {
  const LeaseAgreementsDetail({super.key});

  @override
  State<LeaseAgreementsDetail> createState() => _LeaseAgreementsDetailState();
}

class _LeaseAgreementsDetailState extends State<LeaseAgreementsDetail> {
  final LeaseAgreementsDetailController controller =
      Get.put(LeaseAgreementsDetailController());

  @override
  Widget build(BuildContext context) {
    Get.put(LeaseAgreementsDetailController());
    return Scaffold(
      appBar: const CustomMyAccountItemAppBar(title: "Sözleşme Detayı"),
      backgroundColor:
          Get.isDarkMode ? AppColors.SOOTY : AppColors.ZHEN_ZHU_BAI_PEARL,
      body: Obx(
        () => controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(
                  color: AppColors.ASHENVALE_NIGHTS,
                ),
              )
            : Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 5.w,
                  vertical: 2.h,
                ),
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 10.h),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Sözleşme Bilgileri:",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall
                                    ?.copyWith(
                                      color: Get.isDarkMode
                                          ? AppColors.WHITE.withOpacity(.5)
                                          : AppColors.ASHENVALE_NIGHTS,
                                    ),
                              ),
                            ),
                            Direction.vertical.spacer(1),
                            Container(
                              width: 100.w,
                              decoration: BoxDecoration(
                                color: Get.isDarkMode
                                    ? AppColors.BLACK_WASH
                                    : AppColors.WHITE,
                                borderRadius: AppBorderRadius.inputRadius,
                                border: Border.all(
                                  color: AppColors.SHY_MOMENT,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 3.w,
                                      vertical: 1.h,
                                    ),
                                    child: CustomAltTextRich(
                                      text: "Sahip Adı: ",
                                      color: Get.isDarkMode
                                          ? AppColors.WHITE.withOpacity(.5)
                                          : AppColors.ASHENVALE_NIGHTS,
                                      subtext: controller.leaseAgreementsDetail
                                          .first.sozlesmeDetay.sahipAdi,
                                    ),
                                  ),
                                  const CustomSeperatorWidget(
                                    color: AppColors.SHY_MOMENT,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 3.w,
                                      vertical: 1.h,
                                    ),
                                    child: CustomAltTextRich(
                                      text: "Sahip Soyadı: ",
                                      color: Get.isDarkMode
                                          ? AppColors.WHITE.withOpacity(.5)
                                          : AppColors.ASHENVALE_NIGHTS,
                                      subtext: controller.leaseAgreementsDetail
                                          .first.sozlesmeDetay.sahipSoyadi,
                                    ),
                                  ),
                                  const CustomSeperatorWidget(
                                    color: AppColors.SHY_MOMENT,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 3.w,
                                      vertical: 1.h,
                                    ),
                                    child: CustomAltTextRich(
                                      text: "Sahip Cep Telefonu: ",
                                      color: Get.isDarkMode
                                          ? AppColors.WHITE.withOpacity(.5)
                                          : AppColors.ASHENVALE_NIGHTS,
                                      subtext: controller.leaseAgreementsDetail
                                          .first.sozlesmeDetay.sahipCep,
                                    ),
                                  ),
                                  const CustomSeperatorWidget(
                                    color: AppColors.SHY_MOMENT,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 3.w,
                                      vertical: 1.h,
                                    ),
                                    child: CustomAltTextRich(
                                      text: "Sahip TC Kimlik No: ",
                                      color: Get.isDarkMode
                                          ? AppColors.WHITE.withOpacity(.5)
                                          : AppColors.ASHENVALE_NIGHTS,
                                      subtext: controller.leaseAgreementsDetail
                                          .first.sozlesmeDetay.sahipTc,
                                    ),
                                  ),
                                  const CustomSeperatorWidget(
                                    color: AppColors.SHY_MOMENT,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 3.w,
                                      vertical: 1.h,
                                    ),
                                    child: CustomAltTextRich(
                                      text: "Kiracı Adı: ",
                                      color: Get.isDarkMode
                                          ? AppColors.WHITE.withOpacity(.5)
                                          : AppColors.ASHENVALE_NIGHTS,
                                      subtext: controller.leaseAgreementsDetail
                                          .first.sozlesmeDetay.kiraciAdi,
                                    ),
                                  ),
                                  const CustomSeperatorWidget(
                                    color: AppColors.SHY_MOMENT,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 3.w,
                                      vertical: 1.h,
                                    ),
                                    child: CustomAltTextRich(
                                      text: "Kiracı Soyadı: ",
                                      color: Get.isDarkMode
                                          ? AppColors.WHITE.withOpacity(.5)
                                          : AppColors.ASHENVALE_NIGHTS,
                                      subtext: controller.leaseAgreementsDetail
                                          .first.sozlesmeDetay.kiraciSoyadi,
                                    ),
                                  ),
                                  const CustomSeperatorWidget(
                                    color: AppColors.SHY_MOMENT,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 3.w,
                                      vertical: 1.h,
                                    ),
                                    child: CustomAltTextRich(
                                      text: "Kiracı Cep Telefonu: ",
                                      color: Get.isDarkMode
                                          ? AppColors.WHITE.withOpacity(.5)
                                          : AppColors.ASHENVALE_NIGHTS,
                                      subtext: controller.leaseAgreementsDetail
                                          .first.sozlesmeDetay.kiraciCep,
                                    ),
                                  ),
                                  const CustomSeperatorWidget(
                                    color: AppColors.SHY_MOMENT,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 3.w,
                                      vertical: 1.h,
                                    ),
                                    child: CustomAltTextRich(
                                      text: "Kiracı TC Kimlik No: ",
                                      color: Get.isDarkMode
                                          ? AppColors.WHITE.withOpacity(.5)
                                          : AppColors.ASHENVALE_NIGHTS,
                                      subtext: controller.leaseAgreementsDetail
                                          .first.sozlesmeDetay.kiraciTc,
                                    ),
                                  ),
                                  const CustomSeperatorWidget(
                                    color: AppColors.SHY_MOMENT,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 3.w,
                                      vertical: 1.h,
                                    ),
                                    child: CustomAltTextRich(
                                      text: "Kira Süresi: ",
                                      color: Get.isDarkMode
                                          ? AppColors.WHITE.withOpacity(.5)
                                          : AppColors.ASHENVALE_NIGHTS,
                                      subtext: controller.leaseAgreementsDetail
                                          .first.sozlesmeDetay.kiraSuresi,
                                    ),
                                  ),
                                  const CustomSeperatorWidget(
                                    color: AppColors.SHY_MOMENT,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 3.w,
                                      vertical: 1.h,
                                    ),
                                    child: CustomAltTextRich(
                                      text: "Kira Başlangıç Tarihi: ",
                                      color: Get.isDarkMode
                                          ? AppColors.WHITE.withOpacity(.5)
                                          : AppColors.ASHENVALE_NIGHTS,
                                      subtext: controller
                                          .leaseAgreementsDetail
                                          .first
                                          .sozlesmeDetay
                                          .kiraBaslangicTarihi,
                                    ),
                                  ),
                                  const CustomSeperatorWidget(
                                    color: AppColors.SHY_MOMENT,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 3.w,
                                      vertical: 1.h,
                                    ),
                                    child: CustomAltTextRich(
                                      text: "Adres: ",
                                      color: Get.isDarkMode
                                          ? AppColors.WHITE.withOpacity(.5)
                                          : AppColors.ASHENVALE_NIGHTS,
                                      subtext: controller.leaseAgreementsDetail
                                          .first.sozlesmeDetay.kiraAdres,
                                    ),
                                  ),
                                  const CustomSeperatorWidget(
                                    color: AppColors.SHY_MOMENT,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 3.w,
                                      vertical: 1.h,
                                    ),
                                    child: CustomAltTextRich(
                                      text: "Kira Ücreti: ",
                                      color: Get.isDarkMode
                                          ? AppColors.WHITE.withOpacity(.5)
                                          : AppColors.ASHENVALE_NIGHTS,
                                      subtext: controller.leaseAgreementsDetail
                                          .first.sozlesmeDetay.kiraUcreti,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 3.w,
                      right: 3.w,
                      bottom: 2.h,
                      child: CustomButton(
                        title: "Sil",
                        isLoading: controller.isDeleteLoading.value,
                        bg: AppColors.HORNET_STING,
                        onTap: () => controller.deleteLeaseAgreement(),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
