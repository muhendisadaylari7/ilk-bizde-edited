// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:ilkbizde/modules/Notification/NotificationController.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/enum/images.dart';
import 'package:ilkbizde/shared/widgets/index.dart';
import 'package:sizer/sizer.dart';

class Notification extends StatefulWidget {
  const Notification({super.key});

  @override
  State<Notification> createState() => _NotificationState();
}

class _NotificationState extends State<Notification> {
  final NotificationController controller = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    Get.put(NotificationController());
    return Scaffold(
      appBar: const CustomMyAccountItemAppBar(title: "Bildirimler"),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(
                color: AppColors.ASHENVALE_NIGHTS,
              ))
            : controller.notificationList.isEmpty
                ? Center(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Images.noNotifications.pngWithScale,
                      Direction.vertical.spacer(2),
                      Text(
                        "Bildirim bulunamadı",
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ],
                  ))
                : ListView.separated(
                    itemCount: controller.notificationList.length,
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.w,
                      vertical: 2.h,
                    ),
                    separatorBuilder: (context, index) =>
                        Direction.vertical.spacer(2),
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: AppBorderRadius.inputRadius,
                          color: AppColors.WHITE,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.BLACK.withOpacity(.25),
                              blurRadius: 4,
                              spreadRadius: 0,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ListTile(
                          title: Text(
                            controller.notificationList[index].adTitle ?? "",
                            style: Theme.of(context).textTheme.labelSmall,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Container(
                            margin: EdgeInsets.only(top: 1.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller
                                      .notificationList[index].notification,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(
                                        color: AppColors.ASHENVALE_NIGHTS,
                                      ),
                                ),
                                Direction.vertical.spacer(.5),
                                Text(
                                  controller
                                      .notificationList[index].notificationDate,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(
                                        color: AppColors.SILVER,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          trailing: Obx(
                            () => Bounceable(
                              onTap: controller.isDeleteLoading.value
                                  ? null
                                  : () => controller.deleteNotification(
                                      notificationId: controller
                                          .notificationList[index].notId),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 1.6.w, vertical: .65.h),
                                decoration: BoxDecoration(
                                  color: AppColors.BLACK.withOpacity(.05),
                                  borderRadius: AppBorderRadius.inputRadius,
                                ),
                                child: const Icon(
                                  Icons.delete,
                                  color: AppColors.FLUORESCENT_RED,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
