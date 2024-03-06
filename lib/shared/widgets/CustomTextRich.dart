import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ilkbizde/shared/constants/index.dart';

class CustomTextRich extends StatelessWidget {
  final String text1;
  final String text2;
  final Color? text2Color;
  final void Function()? text2OnTap;
  const CustomTextRich({
    super.key,
    required this.text1,
    required this.text2,
    this.text2Color,
    this.text2OnTap,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: text1,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppColors.OBSIDIAN_SHARD.withOpacity(.4),
              fontFamily: AppFonts.medium,
            ),
        children: [
          const TextSpan(text: " "),
          TextSpan(
            text: text2,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: text2Color ?? AppColors.BLUE_RIBBON,
                  fontFamily: AppFonts.semiBold,
                ),
            recognizer: TapGestureRecognizer()..onTap = text2OnTap,
          ),
        ],
      ),
    );
  }
}
