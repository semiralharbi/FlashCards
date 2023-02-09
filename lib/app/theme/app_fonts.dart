import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_dimensions.dart';

class AppFonts {
  const AppFonts._();
  static const regularPermanentMarker16 = TextStyle(
    fontFamily: 'PermanentMarker',
    fontWeight: FontWeight.w400,
    fontSize: AppDimensions.d16,
    color: AppColors.electricViolet,
  );
  static const boldPermanentMarker16 = TextStyle(
    fontFamily: 'PermanentMarker',
    fontWeight: FontWeight.w600,
    fontSize: AppDimensions.d16,
    color: AppColors.confetti,
  );
  static const regularPermanentMarker18 = TextStyle(
    fontFamily: 'PermanentMarker',
    fontWeight: FontWeight.w400,
    fontSize: AppDimensions.d18,
    color: AppColors.electricViolet,
  );
  static const boldPermanentMarker18 = TextStyle(
    fontFamily: 'PermanentMarker',
    fontWeight: FontWeight.w600,
    fontSize: AppDimensions.d18,
    color: AppColors.electricViolet,
  );
  static const boldPermanentMarker = TextStyle(
    fontFamily: 'PermanentMarker',
    fontWeight: FontWeight.w600,
  );
  static const regularPermanentMarker = TextStyle(
    fontFamily: 'PermanentMarker',
    fontWeight: FontWeight.w400,
  );
}
