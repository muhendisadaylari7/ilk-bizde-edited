// ignore_for_file: non_constant_identifier_names, file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/colors.dart';

enum SnackbarType {
  error,
  success,
}

extension CustomSnackbarExtension on SnackbarType {
  SnackbarController CustomSnackbar({
    required String title,
    required String message,
  }) {
    Color? bg;
    switch (this) {
      case SnackbarType.error:
        bg = AppColors.USC_GOLD;
      case SnackbarType.success:
        bg = AppColors.AQUA_FOREST;
      default:
        bg = AppColors.FADED_RED;
    }
    return Get.snackbar(
      title,
      message,
      backgroundColor: bg,
      isDismissible: false,
      colorText: bg == AppColors.USC_GOLD ? AppColors.BLACK : AppColors.WHITE,
    );
  }
}
