import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/enum/images.dart';
import 'package:sizer/sizer.dart';

class CustomMyAccountItem extends StatelessWidget {
  final String title;
  final Images? image;
  final IconData? icon;
  final void Function()? onTap;
  const CustomMyAccountItem({
    super.key,
    required this.title,
    this.image,
    this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: onTap,
      child: Container(
        width: 100.w,
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 4.h,
              height: 4.h,
              decoration: BoxDecoration(
                color: Get.isDarkMode
                    ? AppColors.BRANDEIS_BLUE.withOpacity(.1)
                    : AppColors.SHY_MOMENT.withOpacity(.1),
                borderRadius: AppBorderRadius.inputRadius,
              ),
              child: image?.pngWithColor(
                    Get.isDarkMode
                        ? AppColors.BRANDEIS_BLUE
                        : AppColors.SHY_MOMENT,
                    scale: 3,
                  ) ??
                  Icon(
                    icon,
                    color: Get.isDarkMode
                        ? AppColors.BRANDEIS_BLUE
                        : AppColors.SHY_MOMENT,
                  ),
            ),
            Direction.horizontal.spacer(2),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Get.isDarkMode ? AppColors.WHITE : AppColors.CORBEAU,
                    fontFamily: AppFonts.regular,
                    fontSize: 9.sp,
                  ),
            ),
            const Spacer(),
            Images.myAccountArrowRightIcon.pngWithScale,
          ],
        ),
      ),
    );
  }
}
