// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/enum/images.dart';
import 'package:sizer/sizer.dart';

class CustomLeaseAgreementTextWidget extends StatelessWidget {
  final String text;
  final Images image;
  const CustomLeaseAgreementTextWidget({
    super.key,
    required this.text,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
            width: 1.5.h,
            height: 1.5.h,
            child: image.pngWithColor(AppColors.SHY_MOMENT)),
        Direction.horizontal.spacer(1),
        Expanded(
          child: Text(
            text,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColors.SHY_MOMENT,
                ),
          ),
        ),
      ],
    );
  }
}
