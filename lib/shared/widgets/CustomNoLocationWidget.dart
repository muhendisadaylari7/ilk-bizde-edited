// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/enum/images.dart';

class CustomNoLocationWidget extends StatelessWidget {
  const CustomNoLocationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Center(
        child: Padding(
          padding: AppPaddings.generalPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Images.noLocation.pngWithScale,
              Direction.vertical.spacer(2.6),
              Text(
                "Uygulamayı Kullanabilmeniz İçin Konum İzni Vermeniz Gerekmektedir",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppColors.ASHENVALE_NIGHTS,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
