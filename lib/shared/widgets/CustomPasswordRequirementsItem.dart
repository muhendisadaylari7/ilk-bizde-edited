// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:sizer/sizer.dart';

class CustomPasswordRequirementsItem extends StatelessWidget {
  final String text;
  const CustomPasswordRequirementsItem({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "\u2981 $text",
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppColors.WHARF_VIEW,
            fontSize: 7.sp,
          ),
    );
  }
}
