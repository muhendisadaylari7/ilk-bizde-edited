import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/enum/MissionType.dart';
import 'package:sizer/sizer.dart';

class CustomMissionTextWidgetFromMissionType extends StatelessWidget {
  final MissionType missionType;
  final String doping;
  final String? price;
  const CustomMissionTextWidgetFromMissionType(
      {super.key, required this.missionType, required this.doping, this.price});

  @override
  Widget build(BuildContext context) {
    return missionType == MissionType.newMember
        ? _CustomMissionTextRich(text: "Yeni üye olana", doping: doping)
        : _CustomMissionTextRich(
            doping: doping,
            text: "${price} TL'den fazla harcama yapana",
          );
  }
}

class _CustomMissionTextRich extends StatelessWidget {
  final String doping;
  final String text;
  const _CustomMissionTextRich({
    required this.doping,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: text,
              style: Theme.of(context).textTheme.labelSmall,
            ),
            TextSpan(
              text: """ "${doping}" """,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Get.isDarkMode ? AppColors.WHITE : AppColors.CORBEAU,
                    fontFamily: AppFonts.semiBold,
                  ),
            ),
            TextSpan(
              text: "hediye",
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ],
        ),
      ),
    );
  }
}
