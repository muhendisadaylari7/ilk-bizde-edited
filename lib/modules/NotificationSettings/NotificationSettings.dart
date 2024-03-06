// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:ilkbizde/modules/NotificationSettings/NotificationSettingsController.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/widgets/index.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:sizer/sizer.dart';

class NotificationSettings extends StatefulWidget {
  const NotificationSettings({super.key});

  @override
  State<NotificationSettings> createState() => _NotificationSettingsState();
}

class _NotificationSettingsState extends State<NotificationSettings> {
  final NotificationSettingsController controller =
      Get.put(NotificationSettingsController());

  @override
  Widget build(BuildContext context) {
    Get.put(NotificationSettingsController());
    return Scaffold(
        appBar: const CustomMyAccountItemAppBar(title: "Bildirim Ayarları"),
        backgroundColor:
            Get.isDarkMode ? AppColors.SOOTY : AppColors.ZHEN_ZHU_BAI_PEARL,
        body: Padding(
          padding: AppPaddings.generalPadding.copyWith(top: 2.h, bottom: 2.h),
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
            // padding: AppPaddings.generalPadding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Bildirimlere izin ver",
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Get.isDarkMode
                            ? AppColors.WHITE
                            : AppColors.CORBEAU,
                      ),
                ),
                Obx(
                  () => Switch(
                    value: controller.isNotificationAllowed.value,
                    onChanged: (value) {
                      controller.isNotificationAllowed.value = value;
                      controller.storage.write("isNotificationAllowed", value);
                      if (value && !OneSignal.Notifications.permission) {
                        OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
                        OneSignal.initialize(
                            dotenv.env['ONE_SIGNAL_APP_ID'].toString());
                        OneSignal.Notifications.requestPermission(true)
                            .then((val) {
                          controller.isNotificationAllowed.value = val;
                          controller.storage
                              .write("isNotificationAllowed", val);
                        });
                      }
                    },
                    activeTrackColor: AppColors.VERDANT_OASIS.withOpacity(.3),
                    inactiveTrackColor: AppColors.WHITE,
                    activeColor: AppColors.IMAGINATION,
                    thumbColor: MaterialStateColor.resolveWith(
                        (states) => AppColors.VERDANT_OASIS),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
