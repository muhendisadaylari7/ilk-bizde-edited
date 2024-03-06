import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/widgets/index.dart';
import 'package:sizer/sizer.dart';

class CustomAreUSureDialog extends StatelessWidget {
  final String title;
  final bool isLoading;
  final void Function()? yesOnTap;
  const CustomAreUSureDialog(
      {super.key, required this.title, required this.isLoading, this.yesOnTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 70.w,
        child: Material(
          borderRadius: AppBorderRadius.inputRadius,
          color: Get.isDarkMode ? AppColors.SOOTY : AppColors.WHITE,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 3.w,
              vertical: 3.h,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: Theme.of(Get.context!).textTheme.labelSmall,
                ),
                Direction.vertical.spacer(2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomDialogButton(
                      onTap: () => Get.back(),
                      color: Get.isDarkMode
                          ? AppColors.BRANDEIS_BLUE.withOpacity(.1)
                          : AppColors.WHITE,
                      text: "Hayır",
                      textColor: Get.isDarkMode
                          ? AppColors.WHITE
                          : AppColors.ASHENVALE_NIGHTS,
                    ),
                    CustomDialogButton(
                      onTap: yesOnTap,
                      isLoading: isLoading,
                      color: Get.isDarkMode
                          ? AppColors.BRANDEIS_BLUE
                          : AppColors.ASHENVALE_NIGHTS,
                      text: "Evet",
                      textColor: AppColors.WHITE,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
