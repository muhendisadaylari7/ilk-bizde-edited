import 'package:flutter/material.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/widgets/index.dart';
import 'package:sizer/sizer.dart';

class CustomDialogWithIcon extends StatelessWidget {
  final Widget image;
  final String title;
  final String subtitle;
  final String firstButtonText;
  final void Function()? firstOnTap;
  final String secondButtonText;
  final void Function()? secondOnTap;
  const CustomDialogWithIcon(
      {super.key,
      required this.image,
      required this.title,
      required this.subtitle,
      this.firstOnTap,
      this.secondOnTap,
      required this.firstButtonText,
      required this.secondButtonText});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 5.w,
          vertical: 2.h,
        ),
        child: Material(
          color: AppColors.WHITE,
          borderRadius: AppBorderRadius.inputRadius,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 5.w,
              vertical: 3.h,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(3.w),
                      decoration: BoxDecoration(
                        color: AppColors.WHITE_SMOKE,
                        borderRadius: AppBorderRadius.inputRadius,
                      ),
                      child: image,
                    ),
                    Direction.horizontal.spacer(2),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                                  color: AppColors.ASHENVALE_NIGHTS,
                                  fontFamily: AppFonts.semiBold,
                                ),
                          ),
                          Text(
                            subtitle,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontFamily: AppFonts.regular,
                                  color:
                                      AppColors.EDGE_OF_BLACK.withOpacity(.6),
                                ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Direction.vertical.spacer(2),
                secondButtonText.isEmpty
                    ? CustomDialogButton(
                        onTap: firstOnTap,
                        color: AppColors.ASHENVALE_NIGHTS,
                        text: firstButtonText,
                        textColor: AppColors.WHITE,
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomDialogButton(
                            onTap: firstOnTap,
                            color: AppColors.WHITE,
                            text: firstButtonText,
                            textColor: AppColors.ASHENVALE_NIGHTS,
                          ),
                          CustomDialogButton(
                            onTap: secondOnTap,
                            color: AppColors.ASHENVALE_NIGHTS,
                            text: secondButtonText,
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
