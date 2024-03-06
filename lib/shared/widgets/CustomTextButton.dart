import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:ilkbizde/shared/constants/index.dart';

class CustomTextButton extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  final TextStyle? style;
  const CustomTextButton({
    super.key,
    required this.title,
    required this.onTap,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: onTap,
      child: Text(
        title,
        style: style ??
            Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColors.ASHENVALE_NIGHTS,
                  fontFamily: AppFonts.medium,
                ),
      ),
    );
  }
}
