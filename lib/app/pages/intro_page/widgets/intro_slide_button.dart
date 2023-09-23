import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_dimensions.dart';

class IntroSlideButton extends StatelessWidget {
  const IntroSlideButton({
    super.key,
    required this.animation,
    required this.alignment,
    required this.text,
    required this.borderRadius,
    required this.transitionOffset,
    required this.destinationPage,
    this.margin,
  });

  final Animation<Offset> animation;
  final Alignment alignment;
  final String text;
  final EdgeInsets? margin;
  final BorderRadius borderRadius;
  final Offset transitionOffset;
  final PageRouteInfo<dynamic> destinationPage;

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: animation,
      child: Align(
        alignment: alignment,
        child: Container(
          margin: margin,
          constraints: const BoxConstraints(minHeight: AppDimensions.d74),
          decoration: BoxDecoration(
            color: AppColors.white,
            boxShadow: const [
              BoxShadow(
                color: AppColors.daintree,
                blurRadius: AppDimensions.d4,
              ),
            ],
            border: Border.all(color: AppColors.daintree),
            borderRadius: borderRadius,
          ),
          child: InkWell(
            borderRadius: borderRadius,
            splashColor: AppColors.blueStone,
            onTap: () async => context.router.push(destinationPage),
            child: Center(
              child: Text(
                text,
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
