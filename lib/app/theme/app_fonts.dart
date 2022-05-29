import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_dimensions.dart';


class AppFonts {
  const AppFonts._();

  static const boldMontserrat = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w700,
  );

  static const regularMontserrat = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w400,
  );

  static const boldMontserrat16 = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w600,
    fontSize: AppDimensions.d16,
    color: AppColors.regalBlue,
  );

  static const regularMontserrat14 = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w400,
    fontSize: AppDimensions.d14,
    color: AppColors.regalBlue,
  );
}
