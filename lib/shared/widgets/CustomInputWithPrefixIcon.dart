import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/enum/images.dart';
import 'package:sizer/sizer.dart';

class CustomInputWithPrefixIcon extends StatelessWidget {
  final String hintText;
  final Images? image;
  final TextInputAction? textInputAction;
  final bool isPhoneNumber;
  final TextEditingController textEditingController;
  final String? Function(String?)? validator;
  final bool? obscureText;
  final void Function(String)? onFieldSubmitted;
  const CustomInputWithPrefixIcon({
    super.key,
    required this.hintText,
    this.image,
    this.textInputAction,
    this.isPhoneNumber = false,
    required this.textEditingController,
    this.validator,
    this.onFieldSubmitted,
    this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText ?? false,
      validator: validator,
      controller: textEditingController,
      onFieldSubmitted: onFieldSubmitted,
      textInputAction: textInputAction ?? TextInputAction.next,
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      cursorColor: AppColors.OBSIDIAN_SHARD,
      keyboardType: isPhoneNumber ? TextInputType.phone : null,
      inputFormatters: isPhoneNumber
          ? [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(10),
            ]
          : null,
      style: Theme.of(context)
          .textTheme
          .labelMedium
          ?.copyWith(color: AppColors.OBSIDIAN_SHARD),
      decoration: InputDecoration(
        prefixIcon: isPhoneNumber
            ? SizedBox(
                width: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox.shrink(),
                    Text(
                      "+90",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    Container(
                      height: 2.h,
                      color: AppColors.BERRY_CHALK,
                      width: .2.w,
                    ),
                    const SizedBox.shrink(),
                  ],
                ),
              )
            : image?.pngWithScale,
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.labelMedium,
        contentPadding: EdgeInsets.symmetric(horizontal: 2.w),
      ),
    );
  }
}
