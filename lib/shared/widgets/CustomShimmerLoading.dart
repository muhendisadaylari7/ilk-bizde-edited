// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmerLoading extends StatelessWidget {
  final Widget child;
  const CustomShimmerLoading({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.SILVER.withOpacity(.1),
      highlightColor: AppColors.WHITE,
      child: Column(
        children: [
          child,
        ],
      ),
    );
  }
}
