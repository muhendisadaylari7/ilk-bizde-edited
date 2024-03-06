// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:sizer/sizer.dart';

class CustomTheme {
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.SOOTY,
    useMaterial3: true,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      surfaceTintColor: Colors.transparent,
      backgroundColor: AppColors.TRAPPED_DARKNESS,
      foregroundColor: AppColors.WHITE,
      titleTextStyle: TextStyle(
        fontSize: 12.5.sp,
        fontFamily: AppFonts.medium,
        color: AppColors.WHITE,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all(
          TextStyle(
            fontSize: 14,
            fontFamily: AppFonts.medium,
            color: AppColors.WHITE,
          ),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: AppBorderRadius.inputRadius,
          ),
        ),
        backgroundColor: MaterialStateProperty.all(AppColors.BLACK_WASH),
        foregroundColor: MaterialStateProperty.all(AppColors.WHITE),
      ),
    ),
    dialogBackgroundColor: AppColors.WHITE,
    datePickerTheme: DatePickerThemeData(
      surfaceTintColor: AppColors.SOOTY,
      todayBackgroundColor: MaterialStateColor.resolveWith(
        (states) => AppColors.WHITE.withOpacity(.5),
      ),
      headerForegroundColor: AppColors.WHITE,
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(
          fontSize: 14,
          fontFamily: AppFonts.regular,
          color: AppColors.WHITE,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppBorderRadius.inputRadius,
          borderSide: BorderSide(
            width: .2.w,
            color: AppColors.WHITE.withOpacity(.5),
          ),
        ),
        hintStyle: TextStyle(
          fontSize: 14,
          fontFamily: AppFonts.regular,
          color: AppColors.SILVER,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppBorderRadius.inputRadius,
          borderSide: BorderSide(
            width: .2.w,
            color: AppColors.WHITE.withOpacity(.5),
          ),
        ),
      ),
      todayForegroundColor: MaterialStateColor.resolveWith(
        (states) => AppColors.BLACK,
      ),
      backgroundColor: AppColors.SOOTY,
      dayBackgroundColor: MaterialStateColor.resolveWith(
        (states) => states.contains(MaterialState.selected)
            ? AppColors.WHITE
            : AppColors.SOOTY,
      ),
      dayForegroundColor: MaterialStateColor.resolveWith(
        (states) => states.contains(MaterialState.selected)
            ? AppColors.BLACK
            : AppColors.WHITE,
      ),
      yearBackgroundColor: MaterialStateColor.resolveWith(
        (states) => states.contains(MaterialState.selected)
            ? AppColors.WHITE
            : AppColors.SOOTY,
      ),
      yearForegroundColor: MaterialStateColor.resolveWith(
        (states) => states.contains(MaterialState.selected)
            ? AppColors.BLACK
            : AppColors.WHITE,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: AppColors.BLACK_WASH,
      filled: true,
      focusedBorder: OutlineInputBorder(
        borderRadius: AppBorderRadius.inputRadius,
        borderSide: BorderSide(
          width: .1.w,
          color: AppColors.TETSU_KON_BLUE.withOpacity(.24),
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: AppBorderRadius.inputRadius,
        borderSide: BorderSide(
          width: .1.w,
          color: AppColors.TETSU_KON_BLUE.withOpacity(.24),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: AppBorderRadius.inputRadius,
        borderSide: BorderSide(
          width: .1.w,
          color: AppColors.TETSU_KON_BLUE.withOpacity(.24),
        ),
      ),
      errorStyle: TextStyle(
        fontSize: 8.sp,
        fontFamily: AppFonts.medium,
        color: AppColors.FADED_RED,
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: AppBorderRadius.inputRadius,
        borderSide: BorderSide(
          color: AppColors.FADED_RED,
          width: .3.w,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: AppBorderRadius.inputRadius,
        borderSide: BorderSide(
          color: AppColors.FADED_RED,
          width: .3.w,
        ),
      ),
    ),
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        fontSize: 30,
        color: AppColors.WHITE,
        fontFamily: AppFonts.medium,
      ),
      headlineMedium: TextStyle(
        fontFamily: AppFonts.medium,
        fontSize: 24,
        color: AppColors.ASHENVALE_NIGHTS,
      ),
      headlineSmall: TextStyle(
        fontSize: 14,
        fontFamily: AppFonts.medium,
        color: AppColors.WHITE,
      ),
      labelLarge: TextStyle(
        fontSize: 20,
        fontFamily: AppFonts.semiBold,
        color: AppColors.WHITE,
      ),
      labelMedium: TextStyle(
        color: AppColors.BERRY_CHALK,
        fontSize: 15,
        fontFamily: AppFonts.light,
      ),
      labelSmall: TextStyle(
        fontSize: 14,
        fontFamily: AppFonts.regular,
        color: AppColors.WHITE,
      ),
      titleLarge: TextStyle(
        fontSize: 18,
        fontFamily: AppFonts.medium,
        color: AppColors.BRANDEIS_BLUE,
      ),
      titleMedium: TextStyle(
        color: AppColors.ASHENVALE_NIGHTS,
        fontSize: 11,
        fontFamily: AppFonts.medium,
      ),
      titleSmall: TextStyle(
        color: AppColors.MILLION_GREY,
        fontSize: 9,
        fontFamily: AppFonts.regular,
      ),
    ),
  );
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.WHITE,
    useMaterial3: true,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      surfaceTintColor: Colors.transparent,
      backgroundColor: AppColors.ASHENVALE_NIGHTS,
      foregroundColor: AppColors.WHITE,
      titleTextStyle: TextStyle(
        fontSize: 12.5.sp,
        fontFamily: AppFonts.medium,
        color: AppColors.WHITE,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all(
          TextStyle(
            fontSize: 14,
            fontFamily: AppFonts.medium,
            color: AppColors.WHITE,
          ),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: AppBorderRadius.inputRadius,
          ),
        ),
        backgroundColor: MaterialStateProperty.all(AppColors.ASHENVALE_NIGHTS),
        foregroundColor: MaterialStateProperty.all(AppColors.WHITE),
      ),
    ),
    datePickerTheme: DatePickerThemeData(
      surfaceTintColor: AppColors.WHITE,
      todayBackgroundColor: MaterialStateColor.resolveWith(
        (states) => AppColors.ASHENVALE_NIGHTS.withOpacity(.5),
      ),
      headerForegroundColor: AppColors.BLACK,
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(
          fontSize: 14,
          fontFamily: AppFonts.regular,
          color: AppColors.ASHENVALE_NIGHTS,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppBorderRadius.inputRadius,
          borderSide: BorderSide(
            width: .2.w,
            color: AppColors.ASHENVALE_NIGHTS.withOpacity(.5),
          ),
        ),
        hintStyle: TextStyle(
          fontSize: 14,
          fontFamily: AppFonts.regular,
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
      todayForegroundColor: MaterialStateColor.resolveWith(
        (states) => AppColors.BLACK,
      ),
      backgroundColor: AppColors.WHITE,
      dayBackgroundColor: MaterialStateColor.resolveWith(
        (states) => states.contains(MaterialState.selected)
            ? AppColors.ASHENVALE_NIGHTS
            : AppColors.WHITE,
      ),
      dayForegroundColor: MaterialStateColor.resolveWith(
        (states) => states.contains(MaterialState.selected)
            ? AppColors.WHITE
            : AppColors.BLACK,
      ),
      yearBackgroundColor: MaterialStateColor.resolveWith(
        (states) => states.contains(MaterialState.selected)
            ? AppColors.ASHENVALE_NIGHTS
            : AppColors.WHITE,
      ),
      yearForegroundColor: MaterialStateColor.resolveWith(
        (states) => states.contains(MaterialState.selected)
            ? AppColors.WHITE
            : AppColors.BLACK,
      ),
    ),
    dialogTheme: DialogTheme(
      surfaceTintColor: AppColors.WHITE,
    ),
    dialogBackgroundColor: AppColors.WHITE,
    inputDecorationTheme: InputDecorationTheme(
      fillColor: AppColors.WHITE,
      filled: true,
      focusedBorder: OutlineInputBorder(
        borderRadius: AppBorderRadius.inputRadius,
        borderSide: BorderSide(
          width: .1.w,
          color: AppColors.TETSU_KON_BLUE.withOpacity(.24),
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: AppBorderRadius.inputRadius,
        borderSide: BorderSide(
          width: .1.w,
          color: AppColors.TETSU_KON_BLUE.withOpacity(.24),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: AppBorderRadius.inputRadius,
        borderSide: BorderSide(
          width: .1.w,
          color: AppColors.TETSU_KON_BLUE.withOpacity(.24),
        ),
      ),
      errorStyle: TextStyle(
        fontSize: 8.sp,
        fontFamily: AppFonts.medium,
        color: AppColors.FADED_RED,
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: AppBorderRadius.inputRadius,
        borderSide: BorderSide(
          color: AppColors.FADED_RED,
          width: .3.w,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: AppBorderRadius.inputRadius,
        borderSide: BorderSide(
          color: AppColors.FADED_RED,
          width: .3.w,
        ),
      ),
    ),
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        fontSize: 30,
        color: AppColors.WHITE,
        fontFamily: AppFonts.medium,
      ),
      headlineMedium: TextStyle(
        fontFamily: AppFonts.medium,
        fontSize: 24,
        color: AppColors.ASHENVALE_NIGHTS,
      ),
      headlineSmall: TextStyle(
        fontSize: 14,
        fontFamily: AppFonts.medium,
        color: AppColors.BLACK,
      ),
      labelLarge: TextStyle(
        fontSize: 20,
        fontFamily: AppFonts.semiBold,
        color: AppColors.OBSIDIAN_SHARD,
      ),
      labelMedium: TextStyle(
        color: AppColors.BERRY_CHALK,
        fontSize: 15,
        fontFamily: AppFonts.light,
      ),
      labelSmall: TextStyle(
        fontSize: 14,
        fontFamily: AppFonts.regular,
        color: AppColors.BLACK,
      ),
      titleLarge: TextStyle(
        fontSize: 18,
        fontFamily: AppFonts.medium,
        color: AppColors.WHITE,
      ),
      titleMedium: TextStyle(
        color: AppColors.ASHENVALE_NIGHTS,
        fontSize: 11,
        fontFamily: AppFonts.medium,
      ),
      titleSmall: TextStyle(
        color: AppColors.MILLION_GREY,
        fontSize: 9,
        fontFamily: AppFonts.regular,
      ),
    ),
  );
}
