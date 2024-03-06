// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:sizer/sizer.dart';

class CustomShowcaseAdvertisementSkeleton extends StatelessWidget {
  const CustomShowcaseAdvertisementSkeleton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: SizedBox(
            height: 7.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 100.w,
                  height: 3.h,
                  decoration: BoxDecoration(
                    color: AppColors.WHITE,
                    borderRadius: AppBorderRadius.inputRadius,
                  ),
                ),
                Container(
                  width: 100.w,
                  height: 3.h,
                  decoration: BoxDecoration(
                    color: AppColors.WHITE,
                    borderRadius: AppBorderRadius.inputRadius,
                  ),
                ),
              ],
            ),
          ),
        ),
        Direction.horizontal.spacer(1),
        Container(
          width: 3.h,
          height: 3.h,
          color: AppColors.WHITE,
        ),
      ],
    );
  }
}
