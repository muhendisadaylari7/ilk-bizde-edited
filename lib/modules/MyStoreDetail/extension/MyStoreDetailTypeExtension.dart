import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilkbizde/modules/MyStoreDetail/index.dart';
import 'package:ilkbizde/modules/MyStoreDetail/widgets/index.dart';

enum MyStoreDetailType { counselor }

extension MyStoreDetailTypeExtension on MyStoreDetailType {
  static final MyStoreDetailController controller =
      Get.find<MyStoreDetailController>();
  Widget get addDialogWidget {
    switch (this) {
      case MyStoreDetailType.counselor:
        return CustomAddClientDialogWidget(controller: controller);
      default:
        return SizedBox.shrink();
    }
  }
}
