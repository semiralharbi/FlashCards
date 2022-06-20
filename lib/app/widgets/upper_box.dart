import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_dimensions.dart';

class UpperBox extends StatelessWidget {
  const UpperBox({
    required this.child,
    required this.animationValue,
  });

  final Widget child;
  final bool animationValue;

  @override
  Widget build(BuildContext context) => Positioned(
        left: AppDimensions.d5,
        right: AppDimensions.d4,
        top: MediaQuery.of(context).size.height * 0.152,
        height: AppDimensions.d214,
        child: AnimatedOpacity(
          opacity: animationValue ? 1 : 0,
          duration: const Duration(milliseconds: 600),
          child: Container(
            color: AppColors.greyWhite,
            child: child,
          ),
        ),
      );
}
