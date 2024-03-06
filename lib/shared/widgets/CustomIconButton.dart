// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:sizer/sizer.dart';

class CustomIconButton extends StatelessWidget {
  final void Function()? onTap;
  final Widget child;
  final Color? color;
  const CustomIconButton({
    super.key,
    required this.onTap,
    required this.child,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 1.6.w, vertical: .65.h),
        decoration: BoxDecoration(
          color: color ?? AppColors.WHITE.withOpacity(.1),
          borderRadius: AppBorderRadius.inputRadius,
        ),
        child: child,
      ),
    );
  }
}
