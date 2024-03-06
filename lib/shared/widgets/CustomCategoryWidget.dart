// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/enum/images.dart';
import 'package:sizer/sizer.dart';

class CustomCategoryWidget extends StatelessWidget {
  final Images image;
  final String title;
  final String subtitle;
  final void Function() onTap;
  final Color? iconColor;
  const CustomCategoryWidget({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 3.w,
          vertical: 1.h,
        ),
        decoration: BoxDecoration(
          color: Get.isDarkMode ? AppColors.BLACK_WASH : AppColors.WHITE,
          borderRadius: AppBorderRadius.inputRadius,
        ),
        child: Row(
          mainAxisAlignment: Get.isDarkMode
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          children: [
            image.pngWithColor(iconColor),
            Direction.horizontal.spacer(2),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color:
                            Get.isDarkMode ? AppColors.WHITE : AppColors.BLACK,
                      ),
                ),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.MILLION_GREY,
                        fontSize: 7.sp,
                      ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
