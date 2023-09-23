import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_dimensions.dart';

class IntroSlideTransition extends StatelessWidget {
  const IntroSlideTransition({
    super.key,
    required this.animation,
    required this.alignment,
    required this.borderRadius,
  });

  final Animation<Offset> animation;
  final Alignment alignment;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: animation,
      child: Align(
        alignment: alignment,
        child: Container(
          height: AppDimensions.d86,
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: AppColors.black,
                blurRadius: AppDimensions.d6,
              ),
            ],
            color: AppColors.daintree,
            borderRadius: borderRadius,
          ),
        ),
      ),
    );
  }
}
