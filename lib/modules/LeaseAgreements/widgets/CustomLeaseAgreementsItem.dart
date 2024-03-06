// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:ilkbizde/modules/LeaseAgreements/LeaseAgreementsController.dart';
import 'package:ilkbizde/modules/LeaseAgreements/widgets/CustomLeaseAgreementTextWidget.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/enum/images.dart';
import 'package:sizer/sizer.dart';

class CustomLeaseAgreementsItem extends StatelessWidget {
  final LeaseAgreementsController controller;
  final int index;
  final void Function()? onTap;
  const CustomLeaseAgreementsItem({
    super.key,
    required this.controller,
    required this.index,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(
          horizontal: 3.w,
          vertical: 1.h,
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.only(
                top: 2.h,
                right: 2.8.w,
                bottom: 2.1.h,
                left: 2.9.w,
              ),
              decoration: BoxDecoration(
                borderRadius: AppBorderRadius.inputRadius,
                color: AppColors.ASHENVALE_NIGHTS,
              ),
              child: Images.contract.pngWithScale,
            ),
            Direction.horizontal.spacer(2),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.allLeaseAgreements[index].baslik,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  Direction.vertical.spacer(1),
                  CustomLeaseAgreementTextWidget(
                    text:
                        "Süre: ${controller.allLeaseAgreements[index].kiraSuresi}",
                    image: Images.duration,
                  ),
                  Direction.vertical.spacer(.5),
                  CustomLeaseAgreementTextWidget(
                    text:
                        "Mülk Sahibi: ${controller.allLeaseAgreements[index].mulkSahibiAdi} ${controller.allLeaseAgreements[index].mulkSahibiSoyadi}",
                    image: Images.myAccountActive,
                  ),
                  Direction.vertical.spacer(.5),
                  CustomLeaseAgreementTextWidget(
                    text:
                        "Kiracı: ${controller.allLeaseAgreements[index].kiraciAdi} ${controller.allLeaseAgreements[index].kiraciSoyadi}",
                    image: Images.myAccountActive,
                  ),
                  Direction.vertical.spacer(.5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        controller.allLeaseAgreements[index].fiyat,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: AppColors.ROMAN_EMPIRE_RED,
                            ),
                      ),
                      Text(
                        controller.allLeaseAgreements[index].kiraBaslangic,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: AppColors.ROMAN_EMPIRE_RED,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
