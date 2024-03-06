// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:ilkbizde/modules/AddLeaseAgreement/AddLeaseAgreementController.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/enum/images.dart';
import 'package:ilkbizde/shared/widgets/index.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class AddLeaseAgreement extends StatefulWidget {
  const AddLeaseAgreement({super.key});

  @override
  State<AddLeaseAgreement> createState() => _AddLeaseAgreementState();
}

class _AddLeaseAgreementState extends State<AddLeaseAgreement> {
  final AddLeaseAgreementController controller =
      Get.put(AddLeaseAgreementController());

  @override
  Widget build(BuildContext context) {
    Get.put(AddLeaseAgreementController());
    return Scaffold(
      appBar: const CustomMyAccountItemAppBar(title: "Sözleşme Bilgileri"),
      backgroundColor:
          Get.isDarkMode ? AppColors.SOOTY : AppColors.ZHEN_ZHU_BAI_PEARL,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 3.w,
          vertical: 1.h,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomInputLabel(text: "Başlık:"),
                Direction.vertical.spacer(.5),
                CustomPersonalInfoInput(
                  validator: (p0) {
                    if (p0!.isEmpty) return "Başlık boş bırakılamaz";
                    return null;
                  },
                  textEditingController: controller.titleController,
                ),
                Direction.vertical.spacer(1),
                const CustomInputLabel(text: "Sahip Adı:"),
                Direction.vertical.spacer(.5),
                CustomPersonalInfoInput(
                  validator: (p0) {
                    if (p0!.isEmpty) return "Sahip adı boş bırakılamaz";
                    return null;
                  },
                  textEditingController: controller.ownerNameController,
                ),
                Direction.vertical.spacer(1),
                const CustomInputLabel(text: "Sahip Soyadı:"),
                Direction.vertical.spacer(.5),
                CustomPersonalInfoInput(
                  validator: (p0) {
                    if (p0!.isEmpty) return "Sahip soyadı boş bırakılamaz";
                    return null;
                  },
                  textEditingController: controller.ownerSurnameController,
                ),
                Direction.vertical.spacer(1),
                const CustomInputLabel(text: "Sahip Cep Telefonu:"),
                Direction.vertical.spacer(.5),
                CustomPersonalInfoInput(
                  maxLength: 10,
                  validator: (p0) {
                    if (p0!.isEmpty) {
                      return "Sahip cep telefonu boş bırakılamaz";
                    }
                    if (p0.length < 10) {
                      return "Geçerli bir cep telefonu giriniz";
                    }
                    return null;
                  },
                  isNumberType: true,
                  textEditingController: controller.ownerPhoneController,
                ),
                Direction.vertical.spacer(1),
                const CustomInputLabel(text: "Sahip TC Kimlik No:"),
                Direction.vertical.spacer(.5),
                CustomPersonalInfoInput(
                  maxLength: 11,
                  validator: (p0) {
                    if (p0!.isEmpty) {
                      return "Sahip TC kimlik no boş bırakılamaz";
                    }
                    if (p0.length < 11) {
                      return "Geçerli bir TC kimlik no giriniz";
                    }
                    return null;
                  },
                  isNumberType: true,
                  textEditingController: controller.ownerTcController,
                ),
                Direction.vertical.spacer(1),
                const CustomInputLabel(text: "Kiralık Süresi:"),
                Direction.vertical.spacer(.5),
                Obx(
                  () => CustomDropdownFieldWithList(
                    items: controller.leaseDurations,
                    value: controller.selectedLeaseDuration.value,
                  ),
                ),
                Direction.vertical.spacer(1),
                const CustomInputLabel(text: "Kiracı Adı:"),
                Direction.vertical.spacer(.5),
                CustomPersonalInfoInput(
                    validator: (p0) {
                      if (p0!.isEmpty) return "Kiracı adı boş bırakılamaz";
                      return null;
                    },
                    textEditingController: controller.tenantNameController),
                Direction.vertical.spacer(1),
                const CustomInputLabel(text: "Kiracı Soyadı:"),
                Direction.vertical.spacer(.5),
                CustomPersonalInfoInput(
                  validator: (p0) {
                    if (p0!.isEmpty) return "Kiracı soyadı boş bırakılamaz";
                    return null;
                  },
                  textEditingController: controller.tenantSurnameController,
                ),
                Direction.vertical.spacer(1),
                const CustomInputLabel(text: "Kiracı Cep Telefonu:"),
                Direction.vertical.spacer(.5),
                CustomPersonalInfoInput(
                  maxLength: 10,
                  validator: (p0) {
                    if (p0!.isEmpty) {
                      return "Kiracı cep telefonu boş bırakılamaz";
                    }
                    if (p0.length < 10) {
                      return "Geçerli bir cep telefonu giriniz";
                    }
                    return null;
                  },
                  isNumberType: true,
                  textEditingController: controller.tenantPhoneController,
                ),
                Direction.vertical.spacer(1),
                const CustomInputLabel(text: "Kiracı TC Kimlik No:"),
                Direction.vertical.spacer(.5),
                CustomPersonalInfoInput(
                  maxLength: 11,
                  validator: (p0) {
                    if (p0!.isEmpty) {
                      return "Kiracı TC kimlik no boş bırakılamaz";
                    }
                    if (p0.length < 11) {
                      return "Geçerli bir TC kimlik no giriniz";
                    }
                    return null;
                  },
                  isNumberType: true,
                  textEditingController: controller.tenantTcController,
                ),
                Direction.vertical.spacer(1),
                const CustomInputLabel(text: "Kira Başlangıç Tarihi:"),
                Direction.vertical.spacer(.5),
                Bounceable(
                  onTap: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2021),
                      lastDate: DateTime(2025),
                    ).then((value) {
                      if (value == null) return;
                      controller.selectedDate.value = value;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 3.w,
                      vertical: 1.5.h,
                    ),
                    width: 100.w,
                    decoration: BoxDecoration(
                      color: Get.isDarkMode
                          ? AppColors.BLACK_WASH
                          : AppColors.WHITE,
                      borderRadius: AppBorderRadius.inputRadius,
                      border: Border.all(
                        width: .2.w,
                        color: AppColors.ASHENVALE_NIGHTS.withOpacity(.5),
                      ),
                    ),
                    child: Obx(
                      () => Text(
                        DateFormat("yyyy-MM-dd")
                            .format(controller.selectedDate.value),
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: AppColors.HARD_COAL,
                            ),
                      ),
                    ),
                  ),
                ),
                Direction.vertical.spacer(1),
                const CustomInputLabel(text: "Adres:"),
                Direction.vertical.spacer(.5),
                CustomPersonalInfoInput(
                  maxLines: 8,
                  validator: (p0) {
                    if (p0!.isEmpty) return "Adres boş bırakılamaz";
                    return null;
                  },
                  textEditingController: controller.addressController,
                ),
                Direction.vertical.spacer(1),
                const CustomInputLabel(text: "Kiralama Ücreti:"),
                Direction.vertical.spacer(.5),
                CustomPersonalInfoInput(
                  validator: (p0) {
                    if (p0!.isEmpty) return "Kiralama ücreti boş bırakılamaz";
                    return null;
                  },
                  isNumberType: true,
                  textEditingController: controller.leasePriceController,
                ),
                Direction.vertical.spacer(1),
                Row(
                  children: [
                    Images.lockFilled.pngWithScale,
                    Direction.horizontal.spacer(1),
                    Expanded(
                      child: Text(
                        AppStrings.personalInformationNote,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: AppColors.SILVER,
                              fontFamily: AppFonts.light,
                            ),
                      ),
                    ),
                  ],
                ),
                Direction.vertical.spacer(3),
                Obx(
                  () => CustomButton(
                    title: "Kaydet",
                    isLoading: controller.isLoading.value,
                    bg: AppColors.FENNEL_FIESTA,
                    onTap: () {
                      if (controller.formKey.currentState!.validate()) {
                        controller.addLeaseAgreement();
                      }
                    },
                  ),
                ),
                Direction.vertical.spacer(6),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
