import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import 'app_colors.dart';
import 'app_dimensions.dart';
import 'app_fonts.dart';

@singleton
class ThemeManager {
  final _themeData = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.white,
    primaryColor: AppColors.pacificBlue,
    textTheme: TextTheme(
      headline1: AppFonts.boldMontserrat.copyWith(
        color: AppColors.black,
        fontSize: AppDimensions.d24,
      ),
      headline2: AppFonts.boldMontserrat.copyWith(
        color: AppColors.regalBlue,
      ),
      headline3: AppFonts.regularMontserrat.copyWith(
        color: AppColors.regalBlue,
      ),
      button: AppFonts.boldMontserrat.copyWith(
        color: AppColors.white,
        fontSize: AppDimensions.d12,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.disabled)) {
            return AppColors.gallery;
          } else if (states.contains(MaterialState.pressed)) {
            return AppColors.regalBlue;
          }
          return AppColors.pacificBlue;
        }),
      ),
    ),
  );

  ThemeData getTheme() => _themeData;
}
