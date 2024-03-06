// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/enum/images.dart';
import 'package:sizer/sizer.dart';

class CustomAdsDetailIconButton extends StatelessWidget {
  final void Function() onTap;
  final String title;
  final Images icon;
  const CustomAdsDetailIconButton({
    super.key,
    required this.onTap,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: onTap,
      child: Container(
        width: 100.w,
        padding: EdgeInsets.symmetric(
          vertical: 1.5.h,
        ),
        color: Get.isDarkMode
            ? AppColors.BLACK_WASH
            : AppColors.ZHEN_ZHU_BAI_PEARL,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon.pngWithScale,
            Direction.horizontal.spacer(3),
            Text(
              title,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Get.isDarkMode ? null : AppColors.CORBEAU,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
