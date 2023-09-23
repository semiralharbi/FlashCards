import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      displayLarge: AppFonts.boldPermanentMarker.copyWith(
        color: AppColors.daintree,
        fontSize: AppDimensions.d24,
      ),
      displayMedium: GoogleFonts.openSans(
        color: AppColors.daintree,
        fontSize: AppDimensions.d22,
      ),
      displaySmall: GoogleFonts.openSans(
        color: AppColors.daintree,
        fontSize: AppDimensions.d20,
      ),
      headlineMedium: GoogleFonts.openSans(
        fontSize: AppDimensions.d18,
        fontWeight: FontWeight.w600,
        color: AppColors.daintree,
      ),
      labelLarge: GoogleFonts.slabo13px(
        fontSize: AppDimensions.d18,
        fontWeight: FontWeight.w600,
        color: AppColors.daintree,
      ),
      titleMedium: GoogleFonts.openSans(
        fontSize: AppDimensions.d16,
        color: AppColors.daintree,
        letterSpacing: 0.75,
      ),
      titleSmall: GoogleFonts.roboto(
        fontSize: AppDimensions.d14,
        color: AppColors.daintree,
        letterSpacing: 0.75,
      ),
    ),
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

  ThemeData getTheme() => _themeData;
}
