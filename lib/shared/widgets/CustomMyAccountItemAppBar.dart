// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class CustomMyAccountItemAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final void Function()? onBackButtonPressed;
  final Widget? icon;
  final PreferredSizeWidget? bottom;
  final double? height;
  final Widget? rightWidget;
  const CustomMyAccountItemAppBar({
    super.key,
    required this.title,
    this.onBackButtonPressed,
    this.icon,
    this.bottom,
    this.height,
    this.rightWidget,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      bottom: bottom,
      title: Stack(
        children: [
          SizedBox(
            height: preferredSize.height,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 14,
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: preferredSize.height,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Bounceable(
                  onTap: onBackButtonPressed ?? () => Get.back(),
                  child: icon ??
                      Icon(
                        Icons.chevron_left_outlined,
                        size: 35.sp,
                      ),
                ),
                rightWidget ?? const SizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height ?? 6.h);
}
