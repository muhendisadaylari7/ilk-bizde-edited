// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilkbizde/modules/AdvertisementDetail/AdvertisementDetailController.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:sizer/sizer.dart';

class CustomDescTab extends StatelessWidget {
  const CustomDescTab({
    super.key,
    required this.controller,
  });

  final AdvertisementDetailController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            controller.adDetailsInfo[0].adDesc,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Get.isDarkMode ? null : AppColors.CORBEAU,
                ),
          ),
          Direction.vertical.spacer(9),
        ],
      ),
    );
  }
}
