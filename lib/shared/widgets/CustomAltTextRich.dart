import 'package:flutter/material.dart';
import 'package:ilkbizde/shared/constants/fonts.dart';

class CustomAltTextRich extends StatelessWidget {
  final String text;
  final String subtext;
  final Color? color;
  const CustomAltTextRich({
    super.key,
    required this.text,
    required this.subtext,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: text,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontFamily: AppFonts.semiBold,
              color: color,
            ),
        children: [
          TextSpan(
            text: subtext,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: color,
                ),
          ),
        ],
      ),
    );
  }
}
