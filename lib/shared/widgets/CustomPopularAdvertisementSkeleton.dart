// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:sizer/sizer.dart';

class CustomPopularAdvertisementSkeleton extends StatelessWidget {
  const CustomPopularAdvertisementSkeleton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            flex: 3,
            child: SizedBox(
              height: 7.h,
              child: Column(
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
          Expanded(
            child: Container(
              width: 100.w,
              height: 3.h,
              decoration: BoxDecoration(
                color: AppColors.WHITE,
                borderRadius: AppBorderRadius.inputRadius,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
