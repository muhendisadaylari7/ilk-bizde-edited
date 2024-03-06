// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/enum/images.dart';

class CustomNoInternetWidget extends StatelessWidget {
  const CustomNoInternetWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Images.noInternet.pngWithScale,
            Direction.vertical.spacer(2.6),
            Text(
              AppStrings.internetControl,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.ASHENVALE_NIGHTS,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
