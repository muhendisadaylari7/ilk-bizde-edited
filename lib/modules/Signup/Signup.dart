// ignore_for_file: file_names, non_constant_identifier_names, must_be_immutable

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:ilkbizde/controllers/NetworkController.dart';
import 'package:ilkbizde/modules/Signup/SignupController.dart';
import 'package:ilkbizde/routes/app_pages.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/enum/accountType.dart';
import 'package:ilkbizde/shared/enum/companyType.dart';
import 'package:ilkbizde/shared/enum/images.dart';
import 'package:ilkbizde/shared/widgets/index.dart';
import 'package:sizer/sizer.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final SignupController controller = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.WHITE,
        foregroundColor: AppColors.BLACK,
      ),
      body: GetBuilder<NetworkController>(builder: (networkController) {
        if (networkController.connectionType.value == 0) {
          return const CustomNoInternetWidget();
        }
        return SafeArea(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Container(
              padding: AppPaddings.generalPadding,
              alignment: Alignment.center,
              child: Form(
                key: controller.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // LOGO
                    SizedBox(
                      width: 9.6.h,
                      height: 9.6.h,
                      child: Images.appLogo.png,
                    ),
                    Direction.vertical.spacer(8.6),
                    // TITLE
                    const CustomSemiBoldLargeText(
                      title: AppStrings.signupTitle,
                    ),
                    // SUBTITLE
                    const CustomRegularSmallText(
                      title: AppStrings.signupSubtitle,
                    ),
                    Direction.vertical.spacer(4.7),
                    // ACCOUNT TYPE DROPDOWN
                    CustomDropdownFormField(
                      accountType: controller.accountType,
                      firstDropdownMenuItem: AppStrings.corporateMembership,
                      secondDropdownMenuItem: AppStrings.individualMembership,
                    ),
                    Direction.vertical.spacer(2.6),
                    // ONLY CORPORATE MEMBERSHIP
                    Obx(
                      () => controller.accountType.value ==
                              AccountType.corporateMembership.accountType
                          ? Column(
                              children: [
                                // COMPANY TYPE DROPDOWN
                                CustomDropdownFormField(
                                  accountType: controller.companyType,
                                  firstDropdownMenuItem: CompanyType
                                      .soleProprietorship.companyType,
                                  secondDropdownMenuItem:
                                      CompanyType.limitedCompany.companyType,
                                ),
                                Direction.vertical.spacer(2.6),
                                // ADDRESS INPUT
                                CustomInputWithPrefixIcon(
                                  validator: (p0) {
                                    if (p0!.isEmpty) {
                                      return AppStrings.addressEmptyError;
                                    } else if (p0.length < 20) {
                                      return AppStrings.addressLengthError;
                                    }
                                    return null;
                                  },
                                  hintText: AppStrings.addressHintText,
                                  textEditingController:
                                      controller.addressController,
                                ),
                                Direction.vertical.spacer(2.6),
                                // TAX OFFICE INPUT
                                CustomInputWithPrefixIcon(
                                  hintText: AppStrings.taxOfficeHintText,
                                  textEditingController:
                                      controller.taxOfficeController,
                                  validator: (p0) {
                                    if (p0!.isEmpty) {
                                      return AppStrings.taxOfficeEmptyError;
                                    }
                                    return null;
                                  },
                                ),
                                Direction.vertical.spacer(2.6),
                                // IDENTITY NUMBER INPUT OR TAX NUMBER INPUT
                                controller.companyType.value ==
                                        CompanyType
                                            .soleProprietorship.companyType
                                    ? CustomInputWithPrefixIcon(
                                        hintText:
                                            AppStrings.identityNumberHintText,
                                        textEditingController:
                                            controller.identityNumberController,
                                        validator: (p0) {
                                          if (p0!.isEmpty) {
                                            return AppStrings
                                                .identityNumberEmptyError;
                                          }
                                          return null;
                                        },
                                      )
                                    : CustomInputWithPrefixIcon(
                                        hintText: AppStrings.taxNumberHintText,
                                        textEditingController:
                                            controller.taxNumberController,
                                        validator: (p0) {
                                          if (p0!.isEmpty) {
                                            return AppStrings
                                                .taxNumberEmptyError;
                                          }
                                          return null;
                                        },
                                      ),
                                Direction.vertical.spacer(2.6),
                                // TITLE INPUT
                                controller.accountType.value ==
                                        AccountType
                                            .corporateMembership.accountType
                                    ? Column(
                                        children: [
                                          CustomInputWithPrefixIcon(
                                            hintText: AppStrings.titleHintText,
                                            textEditingController:
                                                controller.titleController,
                                            validator: (p0) {
                                              if (p0!.isEmpty) {
                                                return AppStrings
                                                    .titleEmptyError;
                                              }
                                              return null;
                                            },
                                          ),
                                          Direction.vertical.spacer(2.6),
                                        ],
                                      )
                                    : const SizedBox.shrink(),
                              ],
                            )
                          : const SizedBox.shrink(),
                    ),
                    // NAME AND SURNAME INPUTS
                    Row(
                      children: [
                        // NAME INPUT
                        Expanded(
                          child: CustomInputWithPrefixIcon(
                            hintText: AppStrings.nameHintText,
                            textEditingController: controller.nameController,
                            validator: (p0) {
                              if (p0!.isEmpty) {
                                return AppStrings.nameEmptyError;
                              } else if (p0.length < 2) {
                                return AppStrings.nameLengthError;
                              }
                              return null;
                            },
                          ),
                        ),
                        Direction.horizontal.spacer(1),
                        // SURNAME INPUT
                        Expanded(
                          child: CustomInputWithPrefixIcon(
                            hintText: AppStrings.surnameHintText,
                            textEditingController: controller.surnameController,
                            validator: (p0) {
                              if (p0!.isEmpty) {
                                return AppStrings.surnameEmptyError;
                              } else if (p0.length < 2) {
                                return AppStrings.surnameLengthError;
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    Direction.vertical.spacer(2.6),
                    // EMAIL INPUT
                    CustomInputWithPrefixIcon(
                      hintText: AppStrings.emailHintText,
                      image: Images.email,
                      textEditingController: controller.emailController,
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return AppStrings.emailEmptyError;
                        } else if (!controller.emailRegex.hasMatch(p0)) {
                          return AppStrings.emailRegexError;
                        }
                        return null;
                      },
                    ),
                    Direction.vertical.spacer(2.6),
                    // PASSWORD INPUT
                    CustomInputWithPrefixIcon(
                      obscureText: true,
                      hintText: AppStrings.passwordHintText,
                      image: Images.lock,
                      textInputAction: TextInputAction.done,
                      textEditingController: controller.passwordController,
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return AppStrings.passwordEmptyError;
                        } else if (p0.length < 6) {
                          return AppStrings.passwordLengthError;
                        }
                        return null;
                      },
                    ),
                    Direction.vertical.spacer(2.6),
                    // PASSWORD CONFIRMATION INPUT
                    CustomInputWithPrefixIcon(
                      obscureText: true,
                      hintText: AppStrings.passwordConfirmHintText,
                      image: Images.lock,
                      textInputAction: TextInputAction.done,
                      textEditingController:
                          controller.passwordConfirmController,
                      validator: (p0) {
                        if (p0 != controller.passwordController.text) {
                          return AppStrings.passwordConfirmValidatorError;
                        }
                        return null;
                      },
                    ),
                    Direction.vertical.spacer(2.6),
                    // COUNTRY DROPDOWN
                    Obx(
                      () => controller.dropdownIsLoading.value
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.ASHENVALE_NIGHTS,
                              ),
                            )
                          : CustomDropdownFieldWithList(
                              value: controller.selectedCountry.value,
                              items: controller.countries
                                  .map(
                                    (element) => DropdownMenuItem(
                                      onTap: () {
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
                                                color:
                                                    AppColors.OBSIDIAN_SHARD),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                    ),
                    Direction.vertical.spacer(2.6),
                    // CITY DROPDOWN
                    Obx(
                      () => controller.dropdownIsLoading.value
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.ASHENVALE_NIGHTS,
                              ),
                            )
                          : CustomDropdownFieldWithList(
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
                                                color:
                                                    AppColors.OBSIDIAN_SHARD),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                    ),
                    Direction.vertical.spacer(2.6),
                    // DISTRICT DROPDOWN
                    Obx(
                      () => controller.dropdownIsLoading.value
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.ASHENVALE_NIGHTS,
                              ),
                            )
                          : CustomDropdownFieldWithList(
                              value: controller.selectedDistrict.value,
                              items: controller.districts
                                  .map(
                                    (element) => DropdownMenuItem(
                                      value: element.name,
                                      onTap: () {
                                        controller.selectedDistrict.value =
                                            element.name;
                                      },
                                      child: Text(
                                        element.name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium
                                            ?.copyWith(
                                                color:
                                                    AppColors.OBSIDIAN_SHARD),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                    ),
                    Direction.vertical.spacer(2.6),
                    // RULES
                    Row(
                      children: [
                        Obx(
                          () => Switch(
                            value: controller.isRuleAccepted.value,
                            onChanged: (value) {
                              controller.isRuleAccepted.value = value;
                            },
                            activeTrackColor:
                                AppColors.VERDANT_OASIS.withOpacity(.3),
                            inactiveTrackColor: AppColors.WHITE,
                            activeColor: AppColors.IMAGINATION,
                            thumbColor: MaterialStateColor.resolveWith(
                                (states) => AppColors.VERDANT_OASIS),
                          ),
                        ),
                        Direction.horizontal.spacer(1),
                        Expanded(
                          child: Obx(
                            () => Text.rich(
                              TextSpan(
                                text: controller.accountType.value ==
                                        AccountType
                                            .individualMembership.accountType
                                    ? AppStrings.rule1
                                    : AppStrings.rule1.replaceAll(
                                        RegExp(r'\bBireysel\b'),
                                        'Kurumsal',
                                      ),
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall
                                    ?.copyWith(
                                      color: AppColors.BLUE_RIBBON,
                                      fontFamily: AppFonts.medium,
                                    ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    showModalBottomSheet(
                                      context: context,
                                      backgroundColor: AppColors.WHITE,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20.sp),
                                          topRight: Radius.circular(20.sp),
                                        ),
                                      ),
                                      builder: (context) {
                                        return Container(
                                          padding: AppPaddings.generalPadding,
                                          child: SingleChildScrollView(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 2.h,
                                            ),
                                            child: HtmlWidget(
                                              controller.accountType.value ==
                                                      AccountType
                                                          .individualMembership
                                                          .accountType
                                                  ? AppStrings
                                                      .individualUserAgreementContent
                                                  : AppStrings
                                                      .individualUserAgreementContent
                                                      .replaceAll(
                                                      RegExp(r'\bBireysel\b'),
                                                      'Kurumsal',
                                                    ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                children: [
                                  const TextSpan(text: " "),
                                  TextSpan(
                                    text: AppStrings.rule2,
                                    style:
                                        Theme.of(context).textTheme.labelSmall,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Direction.vertical.spacer(2.6),
                    // SIGNUP BUTTON
                    Obx(
                      () => CustomButton(
                        isLoading: controller.isLoading.value,
                        bg: AppColors.BLUE_RIBBON,
                        onTap: () {
                          if (controller.formKey.currentState!.validate()) {
                            print(
                                "ACCOUNT TYPE: ${controller.accountType.value}");
                            print(
                                "COMPANY TYPE: ${controller.companyType.value}");
                            controller.handleRegister();
                          }
                        },
                        title: AppStrings.signupTitle,
                      ),
                    ),
                    Direction.vertical.spacer(5.2),
                    // ALREADY HAVE ACCOUNT BUTTON
                    CustomTextRich(
                      text1: AppStrings.alreadyHaveAccount,
                      text2: AppStrings.loginTitle,
                      text2Color: AppColors.FENNEL_FIESTA,
                      text2OnTap: () => Get.toNamed(Routes.LOGIN),
                    ),
                    Direction.vertical.spacer(2.6),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
