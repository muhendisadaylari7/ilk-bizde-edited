// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:ilkbizde/shared/constants/index.dart';

class CustomInputLabel extends StatelessWidget {
  final String text;
  final Color? textColor;
  const CustomInputLabel({
    super.key,
    required this.text,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: textColor ?? AppColors.SILVER,
          ),
    );
  }
}
