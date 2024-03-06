// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class CustomPersonalInfoInput extends StatelessWidget {
  final String? Function(String?)? validator;
  final TextEditingController? textEditingController;
  final String? hintText;
  final bool isNumberType;
  final int? maxLines;
  final int? maxLength;
  final bool isPrice;
  const CustomPersonalInfoInput({
    super.key,
    this.validator,
    this.textEditingController,
    this.hintText = "",
    this.isNumberType = false,
    this.maxLines,
    this.maxLength,
    this.isPrice = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: textEditingController,
      cursorColor: AppColors.BLACK,
      onChanged: !isPrice
          ? null
          : (value) {
              NumberFormat _numberFormat = NumberFormat.decimalPattern("tr_TR");
              if (isNumberType) {
                textEditingController!.text =
                    _numberFormat.format(double.parse(value));
              }
            },
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: AppColors.HARD_COAL,
          ),
      keyboardType: isNumberType ? TextInputType.number : null,
      inputFormatters:
          isNumberType ? [FilteringTextInputFormatter.digitsOnly] : null,
      maxLines: maxLines,
      maxLength: maxLength,
      buildCounter: (context,
          {required currentLength, required isFocused, maxLength}) {
        return SizedBox();
      },
      decoration: InputDecoration(
        suffixIcon: isPrice
            ? Container(
                width: 5.w,
                alignment: Alignment.center,
                child: Text(
                  "TL",
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.HARD_COAL,
                      ),
                ),
              )
            : null,
        contentPadding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppBorderRadius.inputRadius,
          borderSide: BorderSide(
            width: .2.w,
            color: AppColors.ASHENVALE_NIGHTS.withOpacity(.5),
          ),
        ),
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppColors.SILVER,
            ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppBorderRadius.inputRadius,
          borderSide: BorderSide(
            width: .2.w,
            color: AppColors.ASHENVALE_NIGHTS.withOpacity(.5),
          ),
        ),
      ),
    );
  }
}
