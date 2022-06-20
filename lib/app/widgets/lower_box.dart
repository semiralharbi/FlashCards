import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_dimensions.dart';

class LowerBox extends StatelessWidget {
  const LowerBox({
    required this.child,
    required this.animationValue,
  });

  final Widget child;
  final bool animationValue;

  @override
  Widget build(BuildContext context) => Positioned(
        left: AppDimensions.d5,
        right: AppDimensions.d4,
        bottom: MediaQuery.of(context).size.height * 0.162,
        height: AppDimensions.d214,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 600),
          opacity: animationValue ? 1 : 0,
          child: Container(
            color: AppColors.greyWhite,
            child: child,
          ),
        ),
      );
}
