import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:sizer/sizer.dart';

class CustomDialogButton extends StatelessWidget {
  final void Function()? onTap;
  final Color color;
  final String text;
  final Color textColor;
  final bool isLoading;
  const CustomDialogButton({
    super.key,
    required this.onTap,
    required this.color,
    required this.text,
    required this.textColor,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: isLoading ? null : onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 5.w,
          vertical: .5.h,
        ),
        decoration: BoxDecoration(
          color: color,
          borderRadius: AppBorderRadius.inputRadius,
          border: Border.all(
            width: .3.w,
            color: AppColors.ASHENVALE_NIGHTS,
          ),
        ),
        child: isLoading
            ? Container(
                alignment: Alignment.center,
                width: 2.h,
                height: 2.h,
                child: CircularProgressIndicator(
                  color: AppColors.WHITE,
                  strokeWidth: .4.w,
                ),
              )
            : Text(
                text,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: textColor,
                    ),
              ),
      ),
    );
  }
}
