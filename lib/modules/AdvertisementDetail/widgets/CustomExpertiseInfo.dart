// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:ilkbizde/shared/constants/spacer.dart';
import 'package:sizer/sizer.dart';

class CustomExpertiseInfo extends StatelessWidget {
  final List<String> parts;
  final String title;
  final Color partsTitleColor;
  const CustomExpertiseInfo({
    super.key,
    required this.parts,
    required this.title,
    required this.partsTitleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 1.h,
              height: 1.h,
              color: partsTitleColor,
            ),
            Direction.horizontal.spacer(1),
            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: partsTitleColor,
                    ),
              ),
            ),
          ],
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: parts.length,
          padding: EdgeInsets.symmetric(
            vertical: 1.h,
          ),
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
              child: Text(
                parts[index],
                style: Theme.of(context).textTheme.labelSmall,
              ),
            );
          },
        ),
      ],
    );
  }
}
