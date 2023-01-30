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
      headline1: AppFonts.boldPermanentMarker.copyWith(
        color: AppColors.black,
        fontSize: AppDimensions.d24,
      ),
      headline2: AppFonts.boldJoan.copyWith(
        color: AppColors.daintree,
        fontSize: AppDimensions.d22,
      ),
      headline3: AppFonts.regularJoan.copyWith(
        color: AppColors.daintree,
        fontSize: AppDimensions.d20,
      ),
      button: AppFonts.boldJoan.copyWith(
        color: AppColors.white,
        fontSize: AppDimensions.d12,
      ),
      subtitle1: GoogleFonts.oswald(
        fontSize: AppDimensions.d16,
        letterSpacing: 0.75,
      ),
      subtitle2: GoogleFonts.oswald(
        fontSize: AppDimensions.d14,
        letterSpacing: 0.75,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppDimensions.d8,
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
