import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import 'app_colors.dart';
import 'app_dimensions.dart';

@singleton
class ThemeManager {
  final _themeData = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.white,
    primaryColor: AppColors.pacificBlue,
    fontFamily: 'Nunito',
    textTheme: lightThemeText,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppDimensions.d12,
            ),
            side: const BorderSide(
              color: AppColors.daintree,
            ),
          ),
        ),
        textStyle: MaterialStateProperty.resolveWith<TextStyle>((states) {
          if (states.contains(MaterialState.disabled)) {
            return const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: AppDimensions.d18,
              color: AppColors.daintree,
            );
          } else if (states.contains(MaterialState.pressed)) {
            return const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: AppDimensions.d18,
              color: AppColors.whiteSmoke,
            );
          }
          return const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: AppDimensions.d18,
            color: AppColors.daintree,
          );
        }),
        foregroundColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.disabled)) {
            return AppColors.daintree;
          } else if (states.contains(MaterialState.pressed)) {
            return AppColors.whiteSmoke;
          }
          return AppColors.whiteSmoke;
        }),
        shadowColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.disabled)) {
            return AppColors.gallery;
          } else if (states.contains(MaterialState.pressed)) {
            return AppColors.black;
          }
          return AppColors.black;
        }),
        backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.disabled)) {
            return AppColors.gallery;
          } else if (states.contains(MaterialState.pressed)) {
            return AppColors.aliceBlue;
          }
          return AppColors.whiteSmoke;
        }),
      ),
    ),
  );

  static const Color darkTextColor = AppColors.daintree;

  static TextTheme darkThemeText = const TextTheme(
    displayLarge: TextStyle(
      fontSize: 24,
      color: AppColors.white,
      letterSpacing: 1.05,
      fontWeight: FontWeight.w700,
    ),
    displayMedium: TextStyle(
      fontSize: 20,
      color: AppColors.white,
      letterSpacing: 1.05,
      fontWeight: FontWeight.w700,
    ),
    displaySmall: TextStyle(
      fontSize: 18,
      color: AppColors.white,
      letterSpacing: 1.05,
      fontWeight: FontWeight.w700,
    ),
    bodyLarge: TextStyle(
      fontSize: 18,
      color: AppColors.white,
      letterSpacing: 1.05,
      height: 1.4,
      fontWeight: FontWeight.w700,
    ),
    bodyMedium: TextStyle(
      fontSize: 11,
      color: AppColors.white,
      letterSpacing: 1.05,
      height: 1.4,
      fontWeight: FontWeight.w700,
    ),
    labelLarge: TextStyle(
      fontSize: 22,
      color: AppColors.white,
      fontWeight: FontWeight.w800,
      letterSpacing: 1.05,
    ),
    titleLarge: TextStyle(
      fontSize: 28,
      color: AppColors.white,
      letterSpacing: 1.05,
      fontWeight: FontWeight.w700,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      color: AppColors.white,
      letterSpacing: 1.05,
      fontWeight: FontWeight.w700,
    ),
  );

  static TextTheme lightThemeText = const TextTheme(
    displayLarge: TextStyle(
      fontSize: 24,
      color: darkTextColor,
      letterSpacing: 1.05,
      fontWeight: FontWeight.w700,
    ),
    displayMedium: TextStyle(
      fontSize: 20,
      color: darkTextColor,
      letterSpacing: 1.05,
      fontWeight: FontWeight.w700,
    ),
    displaySmall: TextStyle(
      fontSize: 18,
      color: darkTextColor,
      letterSpacing: 1.05,
      fontWeight: FontWeight.w700,
    ),
    bodyLarge: TextStyle(
      fontSize: 18,
      color: darkTextColor,
      letterSpacing: 1.05,
      height: 1.4,
      fontWeight: FontWeight.w700,
    ),
    bodyMedium: TextStyle(
      fontSize: 11,
      color: darkTextColor,
      letterSpacing: 1.05,
      fontWeight: FontWeight.w700,
    ),
    labelLarge: TextStyle(
      fontSize: 22,
      color: darkTextColor,
      fontWeight: FontWeight.w800,
      letterSpacing: 1.3,
    ),
    titleLarge: TextStyle(
      fontSize: 28,
      color: darkTextColor,
      letterSpacing: 1.05,
      fontWeight: FontWeight.w700,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      color: darkTextColor,
      letterSpacing: 1.05,
      fontWeight: FontWeight.w700,
    ),
  );

  ThemeData getTheme() => _themeData;
}
