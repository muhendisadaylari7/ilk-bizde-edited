// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilkbizde/modules/LeaseAgreements/LeaseAgreementsController.dart';
import 'package:ilkbizde/modules/LeaseAgreements/widgets/index.dart';
import 'package:ilkbizde/routes/app_pages.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/widgets/index.dart';
import 'package:sizer/sizer.dart';

class LeaseAgreements extends StatefulWidget {
  const LeaseAgreements({super.key});

  @override
  State<LeaseAgreements> createState() => _LeaseAgreementsState();
}

class _LeaseAgreementsState extends State<LeaseAgreements> {
  final LeaseAgreementsController controller =
      Get.put(LeaseAgreementsController());

  @override
  Widget build(BuildContext context) {
    Get.put(LeaseAgreementsController());
    return Scaffold(
      appBar: const CustomMyAccountItemAppBar(title: "Sözleşmelerim"),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(
                color: AppColors.ASHENVALE_NIGHTS,
              ))
            : Stack(
                children: [
                  controller.allLeaseAgreements.isEmpty
                      ? Center(
                          child: Text(
                            "SÖZLEŞME BULUNMAMAKTADIR!",
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        )
                      : ListView.separated(
                          itemCount: controller.allLeaseAgreements.length,
                          separatorBuilder: (context, index) =>
                              CustomSeperatorWidget(
                            color: AppColors.SHY_MOMENT.withOpacity(.5),
                          ),
                          itemBuilder: (context, index) {
                            return CustomLeaseAgreementsItem(
                              controller: controller,
                              index: index,
                              onTap: () => Get.toNamed(
                                Routes.LEASEAGREEMENTSDETAIL,
                                parameters: {
                                  "contractId": controller
                                      .allLeaseAgreements[index].sozlesmeId,
                                },
                              ),
                            );
                          },
                        ),
                  Positioned(
                    left: 3.w,
                    right: 3.w,
                    bottom: 2.h,
                    child: CustomButton(
                      title: "Sözleşme Ekle",
                      bg: AppColors.BLUE_RIBBON,
                      onTap: () => Get.toNamed(Routes.ADDLEASEAGREEMENT),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
