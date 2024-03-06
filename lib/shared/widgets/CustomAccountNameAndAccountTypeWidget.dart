import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilkbizde/modules/MyAccount/MyAccountController.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/enum/images.dart';
import 'package:sizer/sizer.dart';

class CustomAccountNameAndAccountTypeWidget extends StatelessWidget {
  final MyAccountController controller;
  const CustomAccountNameAndAccountTypeWidget({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.8.w, vertical: 1.h),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset(0, Get.isDarkMode ? 0 : 5),
            blurRadius: Get.isDarkMode ? 5 : 15,
            spreadRadius: -5,
            color: AppColors.BAI_SE_WHITE,
          )
        ],
        color: Get.isDarkMode ? AppColors.BLACK_WASH : AppColors.WHITE,
        borderRadius: AppBorderRadius.inputRadius,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          controller.personalInformationController.userProfilPic.value
                  .split("/")[5]
                  .isEmpty
              ? Images.profile.pngWithScale
              : CircleAvatar(
                  backgroundColor: AppColors.WHITE,
                  backgroundImage: CachedNetworkImageProvider(
                    controller
                        .personalInformationController.userProfilPic.value,
                  ),
                ),
          Direction.horizontal.spacer(2),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    controller.personalInformationController.nameSurname.value,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Get.isDarkMode
                              ? AppColors.WHITE
                              : AppColors.CORBEAU,
                          fontFamily: AppFonts.regular,
                        ),
                  ),
                ),
                Direction.horizontal.spacer(2),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 2.w,
                    vertical: .5.h,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: AppBorderRadius.inputRadius,
                    color: AppColors.BRANDEIS_BLUE,
                  ),
                  child: Text(
                    controller.getAccountName(
                      controller
                          .personalInformationController.accountType.value,
                    ),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppColors.WHITE,
                          fontFamily: AppFonts.regular,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
