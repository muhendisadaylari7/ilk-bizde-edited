// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilkbizde/modules/Splash/SplashController.dart';
import 'package:ilkbizde/shared/enum/images.dart';
import 'package:ilkbizde/shared/constants/index.dart';

class Splash extends GetView<SplashController> {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    return Scaffold(
      backgroundColor: AppColors.ASHENVALE_NIGHTS,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Images.appLogo.pngWithScale,
            Text(
              AppStrings.appNameUrl,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ],
        ),
      ),
    );
  }
}
