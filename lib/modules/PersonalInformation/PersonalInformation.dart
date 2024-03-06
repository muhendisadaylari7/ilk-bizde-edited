// ignore_for_file: file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilkbizde/modules/PersonalInformation/PersonalInformationController.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/enum/images.dart';
import 'package:ilkbizde/shared/widgets/index.dart';
import 'package:sizer/sizer.dart';

class PersonalInformation extends StatefulWidget {
  const PersonalInformation({super.key});

  @override
  State<PersonalInformation> createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {
  final PersonalInformationController controller =
      Get.put(PersonalInformationController());

  @override
  Widget build(BuildContext context) {
    Get.put(PersonalInformationController());
    return Scaffold(
      appBar: const CustomMyAccountItemAppBar(
        title: AppStrings.personalInformation,
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(
                  color: AppColors.ASHENVALE_NIGHTS,
                ),
              )
            : SingleChildScrollView(
                padding: EdgeInsets.only(bottom: 6.h),
                child: Column(
                  children: [
                    Direction.vertical.spacer(3),
                    Center(
                      child: Column(
                        children: [
                          // PROFILE PHOTO
                          Obx(
                            () => controller.isProfileImageLoading.value
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      color: AppColors.ASHENVALE_NIGHTS,
                                    ),
                                  )
                                : CircleAvatar(
                                    radius: 25.sp,
                                    backgroundImage: controller
                                            .userProfilPic.value
                                            .split("/")[5]
                                            .isNotEmpty
                                        ? CachedNetworkImageProvider(
                                            controller.userProfilPic.value,
                                          )
                                        : null,
                                    backgroundColor: AppColors.AMBIENCE_WHITE,
                                    foregroundColor: AppColors.SILVERSTONE,
                                    child: controller.userProfilPic.value
                                            .split("/")[5]
                                            .isNotEmpty
                                        ? const SizedBox.shrink()
                                        : Icon(
                                            Icons.person,
                                            size: 25.sp,
                                          ),
                                  ),
                          ),
                          Direction.vertical.spacer(.5),
                          // ADD PROFILE PHOTO
                          CustomTextButton(
                            title: AppStrings.addProfilePhoto,
                            onTap: () => controller.uploadProfileImage(),
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                                  color: AppColors.LIGHTISH_BLUE,
                                ),
                          ),
                          Direction.vertical.spacer(1),
                          // REMOVE PROFILE PHOTO
                          Obx(
                            () => CustomTextButton(
                              title: "Profil Fotoğrafını Kaldır",
                              onTap: controller.userProfilPic.value
                                      .split("/")[5]
                                      .isNotEmpty
                                  ? () => controller.deleteProfileImage()
                                  : () {},
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                    color: AppColors.HORNET_STING,
                                  ),
                            ),
                          ),
                          Direction.vertical.spacer(1),
                          Padding(
                            padding: AppPaddings.generalPadding,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CustomInputLabel(
                                    text: AppStrings.nameHintText),
                                Direction.vertical.spacer(.3),
                                // İSİM
                                CustomPersonalInfoInput(
                                  textEditingController:
                                      controller.nameController,
                                ),
                                Direction.vertical.spacer(1),
                                const CustomInputLabel(
                                    text: AppStrings.surnameHintText),
                                Direction.vertical.spacer(.3),
                                // SOYİSİM
                                CustomPersonalInfoInput(
                                  textEditingController:
                                      controller.surnameController,
                                ),
                                Direction.vertical.spacer(1),
                                // TELEFON NUMARASI
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 3.w,
                                    vertical: 1.h,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.ASHENVALE_NIGHTS,
                                      width: .3.w,
                                    ),
                                    borderRadius: AppBorderRadius.inputRadius,
                                    color: AppColors.ASHENVALE_NIGHTS
                                        .withOpacity(.1),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const CustomInputLabel(
                                        text: AppStrings.phoneNumberHintText,
                                        textColor: AppColors.ASHENVALE_NIGHTS,
                                      ),
                                      Direction.vertical.spacer(.3),
                                      CustomPersonalInfoInput(
                                        maxLength: 10,
                                        isNumberType: true,
                                        textEditingController:
                                            controller.phoneController,
                                      ),
                                      Direction.vertical.spacer(1),
                                      Obx(
                                        () => CustomButton(
                                          height: 5.h,
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .labelSmall
                                              ?.copyWith(
                                                color: AppColors.WHITE,
                                              ),
                                          title: "Telefon Numaranı Doğrula",
                                          bg: AppColors.ASHENVALE_NIGHTS,
                                          onTap: () =>
                                              controller.sendVerificationCode(),
                                          isLoading: controller
                                              .isPhoneNumberVerifiedLoading
                                              .value,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                Direction.vertical.spacer(1),
                                const CustomInputLabel(
                                    text: AppStrings.emailHintText),
                                Direction.vertical.spacer(.3),
                                // EMAİL
                                CustomPersonalInfoInput(
                                  validator: (p0) {
                                    if (p0!.isEmpty) {
                                      return AppStrings.emailEmptyError;
                                    } else if (!controller.emailRegex
                                        .hasMatch(p0)) {
                                      return AppStrings.emailRegexError;
                                    }
                                    return null;
                                  },
                                  textEditingController:
                                      controller.emailController,
                                ),
                                Direction.vertical.spacer(1),
                                const CustomInputLabel(
                                    text: AppStrings.country),
                                Direction.vertical.spacer(.3),
                                // COUNTRY DROPDOWN
                                Obx(
                                  () => CustomDropdownFieldWithList(
                                    value: controller.selectedCountry.value,
                                    items: controller.countries
                                        .map(
                                          (element) => DropdownMenuItem(
                                            onTap: () async {
                                              controller.selectedCountry.value =
                                                  element.name;
                                              controller.getCities(
                                                countryCode: element.code,
                                              );
                                            },
                                            value: element.name,
                                            child: Text(
                                              element.name,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelMedium
                                                  ?.copyWith(
                                                      color: AppColors
                                                          .OBSIDIAN_SHARD),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ),
                                Direction.vertical.spacer(1),
                                const CustomInputLabel(text: AppStrings.city),
                                Direction.vertical.spacer(.3),
                                // CITY DROPDOWN
                                Obx(
                                  () => CustomDropdownFieldWithList(
                                    value: controller.selectedCity.value,
                                    items: controller.cities
                                        .map(
                                          (element) => DropdownMenuItem(
                                            onTap: () {
                                              controller.selectedCity.value =
                                                  element.name;
                                              controller.getDistricts(
                                                cityId: element.id,
                                              );
                                            },
                                            value: element.name,
                                            child: Text(
                                              element.name,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelMedium
                                                  ?.copyWith(
                                                      color: AppColors
                                                          .OBSIDIAN_SHARD),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ),
                                Direction.vertical.spacer(1),
                                const CustomInputLabel(
                                    text: AppStrings.district),
                                Direction.vertical.spacer(.3),
                                // DISTRICT DROPDOWN
                                Obx(
                                  () => CustomDropdownFieldWithList(
                                    value: controller.selectedDistrict.value,
                                    items: controller.districts
                                        .map(
                                          (element) => DropdownMenuItem(
                                            value: element.name,
                                            onTap: () {
                                              controller.selectedDistrict
                                                  .value = element.name;
                                            },
                                            child: Text(
                                              element.name,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelMedium
                                                  ?.copyWith(
                                                      color: AppColors
                                                          .OBSIDIAN_SHARD),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ),
                                // KURUMSAL ÜYELİK ORTAK ÖZELLİK
                                Obx(
                                  () => controller.accountType.value == "1"
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Direction.vertical.spacer(1),
                                            const CustomInputLabel(
                                              text: AppStrings.addressHintText,
                                            ),
                                            Direction.vertical.spacer(.3),
                                            CustomPersonalInfoInput(
                                              validator: (p0) {
                                                if (p0!.isEmpty) {
                                                  return AppStrings
                                                      .addressEmptyError;
                                                } else if (p0.length < 20) {
                                                  return AppStrings
                                                      .addressLengthError;
                                                }
                                                return null;
                                              },
                                              textEditingController:
                                                  controller.addressController,
                                            ),
                                          ],
                                        )
                                      : const SizedBox.shrink(),
                                ),
                                Direction.vertical.spacer(1),
                                // KURUMSAL ÜYELİK ŞAHIS ŞİRKETİ ÖZELLİK=1 VE KURUMSAL ÜYELİK LİMİTED ŞİRKET ÖZELLİK=2
                                CustomCorporateSpeacialFeatureWidget(
                                    controller: controller),
                                Direction.vertical.spacer(1),
                                Row(
                                  children: [
                                    Images.lockFilled.pngWithScale,
                                    Direction.horizontal.spacer(1),
                                    Expanded(
                                      child: Text(
                                        AppStrings.personalInformationNote,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall
                                            ?.copyWith(
                                              color: AppColors.SILVER,
                                              fontFamily: AppFonts.light,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                                Direction.vertical.spacer(2),
                                Obx(
                                  () => CustomButton(
                                    title: AppStrings.save,
                                    bg: AppColors.ALOHA,
                                    isLoading: controller.isUpdateLoading.value,
                                    onTap: () => controller.updateUser(),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}

class CustomCorporateSpeacialFeatureWidget extends StatelessWidget {
  final PersonalInformationController controller;
  const CustomCorporateSpeacialFeatureWidget({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.companyType.value == "0" &&
              controller.accountType.value == "1"
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomInputLabel(
                  text: AppStrings.taxOfficeHintText,
                ),
                Direction.vertical.spacer(.3),
                CustomPersonalInfoInput(
                  validator: (p0) {
                    if (p0!.isEmpty) {
                      return AppStrings.taxOfficeEmptyError;
                    }
                    return null;
                  },
                  textEditingController: controller.taxOfficeController,
                ),
                Direction.vertical.spacer(1),
                const CustomInputLabel(
                  text: AppStrings.identityNumberHintText,
                ),
                Direction.vertical.spacer(.3),
                CustomPersonalInfoInput(
                  validator: (p0) {
                    if (p0!.isEmpty) {
                      return AppStrings.identityNumberEmptyError;
                    }
                    return null;
                  },
                  textEditingController: controller.identityNumberController,
                ),
                Direction.vertical.spacer(1),
                const CustomInputLabel(
                  text: AppStrings.titleHintText,
                ),
                Direction.vertical.spacer(.3),
                CustomPersonalInfoInput(
                  validator: (p0) {
                    if (p0!.isEmpty) {
                      return AppStrings.titleEmptyError;
                    }
                    return null;
                  },
                  textEditingController: controller.titleController,
                ),
              ],
            )
          : controller.companyType.value == "1" &&
                  controller.accountType.value == "1"
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomInputLabel(
                      text: AppStrings.taxOfficeHintText,
                    ),
                    Direction.vertical.spacer(.3),
                    CustomPersonalInfoInput(
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return AppStrings.taxOfficeEmptyError;
                        }
                        return null;
                      },
                      textEditingController: controller.taxOfficeController,
                    ),
                    Direction.vertical.spacer(1),
                    const CustomInputLabel(
                      text: AppStrings.taxNumberHintText,
                    ),
                    Direction.vertical.spacer(.3),
                    CustomPersonalInfoInput(
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return AppStrings.taxNumberEmptyError;
                        }
                        return null;
                      },
                      textEditingController: controller.taxNumberController,
                    ),
                    Direction.vertical.spacer(1),
                    const CustomInputLabel(
                      text: AppStrings.titleHintText,
                    ),
                    Direction.vertical.spacer(.3),
                    CustomPersonalInfoInput(
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return AppStrings.titleEmptyError;
                        }
                        return null;
                      },
                      textEditingController: controller.titleController,
                    ),
                  ],
                )
              : const SizedBox.shrink(),
    );
  }
}
