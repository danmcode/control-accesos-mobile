import 'package:access_control/src/themes/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static const fontFamily = 'Poppins';

  static ThemeData mainTheme = ThemeData(
    primaryColor: AppColors.mainColor,
    fontFamily: fontFamily,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    appBarTheme: const AppBarTheme(backgroundColor: AppColors.mainColor),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.mainColor,
    ),
    textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontFamily: fontFamily,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
        displayMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        displaySmall: TextStyle(
          fontFamily: fontFamily,
          fontWeight: FontWeight.normal,
          fontSize: 16,
        ),
        titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        bodyLarge: TextStyle(
          fontFamily: fontFamily,
          fontSize: 16,
        ),
        bodySmall: TextStyle(
          fontFamily: fontFamily,
          fontSize: 12,
        )),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: AppColors.mainColor,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.mainColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        elevation: const MaterialStatePropertyAll(0),
        textStyle: const MaterialStatePropertyAll(
          TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: fontFamily,
              fontSize: 16),
        ),
        padding: const MaterialStatePropertyAll(
          EdgeInsets.all(14),
        ),
        backgroundColor: const MaterialStatePropertyAll(AppColors.mainColor),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      errorStyle: TextStyle(color: AppColors.errorColor, fontSize: 12),
      suffixIconColor: AppColors.iconsGrey,
      focusColor: AppColors.mainColor,
      fillColor: AppColors.mainColor,
      prefixIconColor: AppColors.iconsGrey,
      labelStyle: TextStyle(color: AppColors.greyColor),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.greyColor),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.greyColor),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
    ),
    progressIndicatorTheme:
        const ProgressIndicatorThemeData(color: AppColors.mainColor),
  );
}
