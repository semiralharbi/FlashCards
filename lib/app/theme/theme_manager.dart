import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../gen/fonts.gen.dart';
import 'app_colors.dart';
import 'app_dimensions.dart';

@singleton
class ThemeManager {
  final _themeData = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.white,
    primaryColor: AppColors.pacificBlue,
    fontFamily: FontFamily.nunito,
    textTheme: lightThemeText,
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        elevation: const MaterialStatePropertyAll<double>(2),
        backgroundColor: const MaterialStatePropertyAll<Color>(AppColors.white),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppDimensions.d12,
            ),
          ),
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppDimensions.d12,
            ),
          ),
        ),
        elevation: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return AppDimensions.d4;
          } else {
            return AppDimensions.d2;
          }
        }),
        textStyle: MaterialStateProperty.all<TextStyle>(
          const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: AppDimensions.d16,
            color: AppColors.daintree,
          ),
        ),
        foregroundColor: MaterialStateProperty.all<Color>(AppColors.daintree),
        shadowColor: MaterialStateProperty.all<Color>(AppColors.daintree),
        backgroundColor: MaterialStateProperty.all<Color>(AppColors.white),
      ),
    ),
  );

  static const Color _darkTextColor = AppColors.daintree;

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
      color: _darkTextColor,
      letterSpacing: 1.05,
      fontWeight: FontWeight.w700,
    ),
    displayMedium: TextStyle(
      fontSize: 20,
      color: _darkTextColor,
      letterSpacing: 1.05,
      fontWeight: FontWeight.w700,
    ),
    displaySmall: TextStyle(
      fontSize: 18,
      color: _darkTextColor,
      letterSpacing: 1.05,
      fontWeight: FontWeight.w700,
    ),
    bodyLarge: TextStyle(
      fontSize: 18,
      color: _darkTextColor,
      letterSpacing: 1.05,
      height: 1.4,
      fontWeight: FontWeight.w700,
    ),
    bodyMedium: TextStyle(
      fontSize: 11,
      color: _darkTextColor,
      letterSpacing: 1.05,
      fontWeight: FontWeight.w700,
    ),
    labelLarge: TextStyle(
      fontSize: 22,
      color: _darkTextColor,
      fontWeight: FontWeight.w800,
      letterSpacing: 1.3,
    ),
    titleLarge: TextStyle(
      fontSize: 28,
      color: _darkTextColor,
      letterSpacing: 1.05,
      fontWeight: FontWeight.w700,
    ),
    titleMedium: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: AppDimensions.d16,
      color: _darkTextColor,
      letterSpacing: 1.25,
    ),
    titleSmall: TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: AppDimensions.d14,
      color: AppColors.daintree,
      letterSpacing: 1.05,
    ),
  );

  static CountryListThemeData countryListThemeData = const CountryListThemeData(
    searchTextStyle: TextStyle(
      fontSize: 18,
      color: _darkTextColor,
      letterSpacing: 1.05,
      fontWeight: FontWeight.w700,
    ),
    inputDecoration: InputDecoration(
      icon: Icon(Icons.search),
      hintText: 'Search',
      hintStyle: TextStyle(
        fontSize: 14,
        color: AppColors.sliverChalice,
        letterSpacing: 1.05,
        fontWeight: FontWeight.w700,
      ),
      helperStyle: TextStyle(
        fontSize: 18,
        color: _darkTextColor,
        letterSpacing: 1.05,
        fontWeight: FontWeight.w700,
      ),
      iconColor: AppColors.daintree,
      enabledBorder: UnderlineInputBorder(),
      focusedBorder: UnderlineInputBorder(),
      border: UnderlineInputBorder(),
    ),
  );

  ThemeData getTheme() => _themeData;
}
