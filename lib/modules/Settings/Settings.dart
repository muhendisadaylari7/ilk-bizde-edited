// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilkbizde/modules/Settings/SettingsController.dart';
import 'package:ilkbizde/routes/app_pages.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/enum/images.dart';
import 'package:ilkbizde/shared/widgets/index.dart';
import 'package:sizer/sizer.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final SettingsController controller = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    Get.put(SettingsController());
    return Scaffold(
      appBar: const CustomMyAccountItemAppBar(title: "Ayarlar"),
      backgroundColor: Get.isDarkMode ? null : AppColors.ZHEN_ZHU_BAI_PEARL,
      body: Padding(
        padding: AppPaddings.generalPadding.copyWith(top: 2.h, bottom: 6.h),
        child: Container(
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomMyAccountItem(
                title: AppStrings.personalInformation,
                image: Images.myAccountPersonalInfoIcon,
                onTap: () => Get.toNamed(Routes.PERSONALINFORMATION),
              ),
              Direction.vertical.spacer(2),
              CustomMyAccountItem(
                title: AppStrings.changePassword,
                image: Images.myAccountChangePasswordIcon,
                onTap: () => Get.toNamed(Routes.CHANGEPASSWORD),
              ),
              Direction.vertical.spacer(2),
              CustomMyAccountItem(
                title: "Gizlilik ve Politika",
                icon: Icons.privacy_tip_outlined,
                onTap: () => Get.toNamed(Routes.PRIVACYANDPOLICY),
              ),
              Direction.vertical.spacer(2),
              CustomMyAccountItem(
                title: "Hesabımı Sil",
                icon: Icons.delete_forever_outlined,
                onTap: () => controller.createDeleteAccountDialog(),
              ),
              Direction.vertical.spacer(2),
              CustomMyAccountItem(
                title: "Bildirim Ayarları",
                image: Images.bell,
                onTap: () => Get.toNamed(Routes.NOTIFICATIONSETTINGS),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
