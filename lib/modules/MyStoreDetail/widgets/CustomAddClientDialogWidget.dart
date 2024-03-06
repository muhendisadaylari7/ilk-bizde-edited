import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilkbizde/modules/MyStoreDetail/MyStoreDetailController.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/widgets/index.dart';
import 'package:sizer/sizer.dart';

class CustomAddClientDialogWidget extends StatelessWidget {
  final MyStoreDetailController controller;
  const CustomAddClientDialogWidget({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.symmetric(
        horizontal: 5.w,
        vertical: 2.h,
      ),
      title: Text(
        "Danışman Ekle",
        style: Theme.of(context).textTheme.labelLarge,
      ),
      actions: [
        CustomDialogButton(
          onTap: () => Get.back(),
          color: AppColors.WHITE,
          text: "İptal",
          textColor: AppColors.ASHENVALE_NIGHTS,
        ),
        Obx(
          () => CustomDialogButton(
            isLoading: controller.counselorIsLoading.value,
            onTap: () async {
              if (controller.clientEmailFormKey.currentState!.validate()) {
                await controller.handleAddClient();
              }
            },
            color: AppColors.ASHENVALE_NIGHTS,
            text: "Ekle",
            textColor: AppColors.WHITE,
          ),
        ),
      ],
      content: Form(
        key: controller.clientEmailFormKey,
        child: CustomPersonalInfoInput(
          textEditingController: controller.clientEmailController,
          hintText: "Danışman Mail Adresini Giriniz",
          validator: (p0) {
            if (p0!.isEmpty) {
              return "Danışman mail adresi boş bırakılamaz";
            }
            return null;
          },
        ),
      ),
    );
  }
}
