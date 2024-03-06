// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/enum/images.dart';
import 'package:ilkbizde/shared/widgets/index.dart';

class CustomWithPhoneNumber extends StatelessWidget {
  final String title;
  final Color buttonColor;
  final void Function()? onTap;
  final Images image;
  final String buttonTitle;
  final TextEditingController textEditingController;
  final GlobalKey<FormState> formKey;
  final bool isLoading;
  const CustomWithPhoneNumber({
    super.key,
    required this.title,
    required this.buttonColor,
    required this.onTap,
    required this.image,
    required this.buttonTitle,
    required this.textEditingController,
    required this.formKey,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPaddings.generalPadding,
      child: Column(
        children: [
          Direction.vertical.spacer(4.6),
          image.pngWithScale,
          Direction.vertical.spacer(2.6),
          CustomSemiBoldLargeText(
            title: title,
          ),
          Direction.vertical.spacer(2.6),
          const CustomRegularSmallText(
            title: AppStrings.pleaseEnterPhoneNumber,
          ),
          Direction.vertical.spacer(2.6),
          Form(
            key: formKey,
            child: CustomInputWithPrefixIcon(
              validator: (p0) {
                if (p0!.isEmpty) {
                  return AppStrings.pleaseEnterPhoneNumber;
                }
                return null;
              },
              isPhoneNumber: true,
              hintText: AppStrings.phoneNumberHintText,
              image: Images.email,
              textEditingController: textEditingController,
            ),
          ),
          Direction.vertical.spacer(2.6),
          CustomButton(
            title: buttonTitle,
            bg: buttonColor,
            onTap: onTap,
            isLoading: isLoading,
          ),
        ],
      ),
    );
  }
}
