import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilkbizde/modules/MyStoreDetail/MyStoreDetailController.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/widgets/CustomIconButton.dart';
import 'package:sizer/sizer.dart';

class CustomCounselorTabWidget extends StatelessWidget {
  final MyStoreDetailController controller;
  const CustomCounselorTabWidget({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Tüm Danışmanlar",
          style: Theme.of(context).textTheme.labelLarge,
        ),
        Direction.vertical.spacer(2),
        Expanded(
          child: Obx(
            () => controller.counselorIsLoading.value
                ? Center(
                    child: CircularProgressIndicator(
                      color: AppColors.ASHENVALE_NIGHTS,
                    ),
                  )
                : ListView.separated(
                    physics: ClampingScrollPhysics(),
                    itemCount: controller.allCounselor.length,
                    shrinkWrap: true,
                    separatorBuilder: (context, index) =>
                        Direction.vertical.spacer(1),
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 2.w,
                          vertical: 1.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.SHY_MOMENT.withOpacity(.1),
                          border: Border.all(
                            color: AppColors.SHY_MOMENT,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                controller.allCounselor[index].email,
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                            ),
                            Obx(
                              () => !controller.infos.first.magazaYetki
                                  ? SizedBox.shrink()
                                  : CustomIconButton(
                                      onTap: controller
                                              .deleteClientIsLoading.value
                                          ? null
                                          : () => controller.handleDeleteClient(
                                                counselorId: controller
                                                    .allCounselor[index].id,
                                              ),
                                      child: controller
                                              .deleteClientIsLoading.value
                                          ? SizedBox(
                                              width: 2.h,
                                              height: 2.h,
                                              child: Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  strokeWidth: .5.w,
                                                  color: AppColors
                                                      .ASHENVALE_NIGHTS,
                                                ),
                                              ),
                                            )
                                          : Icon(
                                              Icons.delete,
                                              color: AppColors.ROMAN_EMPIRE_RED,
                                            ),
                                    ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ),
      ],
    );
  }
}
