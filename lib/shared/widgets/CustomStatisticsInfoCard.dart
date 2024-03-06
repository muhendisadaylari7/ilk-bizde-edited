import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/enum/images.dart';
import 'package:sizer/sizer.dart';

class CustomStatisticsInfoCard extends StatelessWidget {
  final String totalVisitors;
  final String totalFavorites;
  const CustomStatisticsInfoCard({
    required this.totalVisitors,
    required this.totalFavorites,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 3.w,
        vertical: 1.h,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.SHY_MOMENT.withOpacity(.2),
          ),
        ),
        color: Get.isDarkMode ? AppColors.BLACK_WASH : AppColors.WHITE,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Images.chart.pngWithColor(
                Get.isDarkMode ? AppColors.WHITE : AppColors.BLACK,
              ),
              Direction.horizontal.spacer(1),
              Text(
                "İstatistik",
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ],
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    SizedBox(
                        width: 1.5.h,
                        height: 1.5.h,
                        child: Images.totalVisitors.pngWithScale),
                    Direction.horizontal.spacer(1),
                    Text(
                      totalVisitors + " Gösterim",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
                Direction.horizontal.spacer(3),
                Row(
                  children: [
                    SizedBox(
                        width: 1.5.h,
                        height: 1.5.h,
                        child: Images.star.pngWithScale),
                    Direction.horizontal.spacer(1),
                    Text(
                      totalFavorites + " Favori",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
