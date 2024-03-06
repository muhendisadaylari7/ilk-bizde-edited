// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/enum/images.dart';
import 'package:sizer/sizer.dart';

class CustomSearchInput extends StatelessWidget {
  final void Function() onTap;
  const CustomSearchInput({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 3),
            blurRadius: 6,
            spreadRadius: -5,
            color: AppColors.ASHENVALE_NIGHTS,
          ),
        ],
      ),
      child: GestureDetector(
        onTap: onTap,
        child: TextFormField(
          enabled: false,
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
          cursorColor: AppColors.BLACK,
          style: Theme.of(context)
              .textTheme
              .labelMedium
              ?.copyWith(color: AppColors.OBSIDIAN_SHARD),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: AppBorderRadius.inputRadius,
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 3.w),
            hintText: AppStrings.searchInputHintText,
            hintStyle: Theme.of(context).textTheme.labelMedium,
            suffixIcon: Images.inputSearch.pngWithScale,
          ),
        ),
      ),
    );
  }
}
