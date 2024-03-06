// ignore_for_file: file_names

import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:sizer/sizer.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Color bg;
  final void Function()? onTap;
  final bool hasIcon;
  final Widget? icon;
  final bool isLoading;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;
  const CustomButton({
    super.key,
    required this.title,
    required this.bg,
    required this.onTap,
    this.hasIcon = false,
    this.icon,
    this.isLoading = false,
    this.height,
    this.padding,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: isLoading ? null : onTap,
      child: Container(
        height: height ?? 6.9.h,
        alignment: Alignment.center,
        width: 100.w,
        padding: padding ?? EdgeInsets.symmetric(horizontal: 5.w),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 4),
              blurRadius: 4,
              spreadRadius: 0,
              color: AppColors.BLACK.withOpacity(.14),
            ),
            BoxShadow(
              offset: const Offset(0, 4),
              blurRadius: 8,
              spreadRadius: 0,
              color: AppColors.WHITE.withOpacity(.15),
              inset: true,
            ),
          ],
          borderRadius: BorderRadius.circular(10),
          color: bg,
        ),
        child: isLoading
            ? Center(
                child: SizedBox(
                  width: (height ?? 5.h) / 2,
                  height: (height ?? 5.h) / 2,
                  child: CircularProgressIndicator(
                    strokeWidth: (height ?? 5.h) / 20,
                    color: AppColors.WHITE,
                  ),
                ),
              )
            : hasIcon
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      icon ?? const SizedBox.shrink(),
                      Direction.horizontal.spacer(3),
                      Expanded(
                        child: Text(
                          title,
                          textAlign: TextAlign.center,
                          style: textStyle ??
                              Theme.of(context).textTheme.labelLarge?.copyWith(
                                    color: AppColors.WHITE,
                                    fontSize: 11.2.sp,
                                  ),
                        ),
                      ),
                    ],
                  )
                : Text(
                    title,
                    textAlign: TextAlign.center,
                    style: textStyle ??
                        Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: AppColors.WHITE,
                              fontSize: 12.5.sp,
                            ),
                  ),
      ),
    );
  }
}
