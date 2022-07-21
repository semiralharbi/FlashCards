import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_dimensions.dart';

class LowerBox extends StatelessWidget {
  const LowerBox({
    required this.child,
    Key? key,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          Positioned(
            bottom: AppDimensions.d120,
            left: AppDimensions.d1,
            right: AppDimensions.d1,
            child: Container(
              height: AppDimensions.d244,
              width: MediaQuery.of(context).size.width,
              color: AppColors.greyWhite,
              child: child,
            ),
          ),
        ],
      );
}
