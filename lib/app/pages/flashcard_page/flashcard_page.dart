import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_dimensions.dart';
import '../../theme/app_paths.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/flashcard_container.dart';
import '../../widgets/rounded_icon_button.dart';

class FlashcardPage extends HookWidget {
  const FlashcardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller = useAnimationController(
      duration: const Duration(milliseconds: 600),
    );
    return AppScaffold(
      onlyBottomWood: true,
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            child: Stack(
              fit: StackFit.expand,
              children: [
                GestureDetector(
                  onTap: () {
                    if (_controller.isCompleted) {
                      _controller.reverse();
                    }
                  },
                  child: const FlashcardContainer(
                    text: 'text',
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (_controller.isDismissed) {
                      _controller.forward(from: 0.0);
                    }
                  },
                  child: AnimatedFlashcard(
                    lastChild: Container(
                      decoration: const BoxDecoration(
                        color: AppColors.daintree,
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            AppDimensions.d16,
                          ),
                        ),
                      ),
                      child: Image.asset(
                        AppPaths.tapHere,
                        color: AppColors.whiteSmoke,
                        fit: BoxFit.scaleDown,
                        scale: 4,
                      ),
                    ),
                    animation: Tween<double>(begin: 0.0, end: 90.0).animate(
                      CurvedAnimation(
                        parent: _controller,
                        curve: const Interval(0.0, 0.6),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          const Spacer(),
          const FlashcardContainer(text: 'text'),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RoundedIconButton(
                elementHeight: AppDimensions.d24,
                stringPath: AppPaths.close,
                buttonColor: AppColors.whiteSmoke,
                iconColor: AppColors.daintree,
                onTap: () {},
              ),
              const SizedBox(
                width: AppDimensions.d26,
              ),
              RoundedIconButton(
                elementHeight: AppDimensions.d44,
                iconData: Icons.check,
                padding: const EdgeInsets.all(AppDimensions.d8),
                onTap: () {},
              ),
            ],
          ),
          const Spacer(flex: 1,),
        ],
      ),
    );
  }
}

class AnimatedFlashcard extends AnimatedWidget {
  const AnimatedFlashcard({
    required this.animation,
    this.child,
    this.first = false,
    this.lastChild,
    Key? key,
  }) : super(listenable: animation, key: key);
  final Animation<double> animation;
  final Widget? child;
  final Widget? lastChild;
  final bool first;
  final double fullAngle = 180.0;
  final double halfAngle = 180.0 / 2.0;

  bool get hasLastChild => lastChild != null;

  @override
  Widget build(BuildContext context) {
    return animation.value == fullAngle && !hasLastChild
        ? const SizedBox.shrink()
        : Transform(
            alignment: hasLastChild ? Alignment.bottomCenter : Alignment.topCenter,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(
                (pi / fullAngle) * (hasLastChild ? animation.value : -animation.value),
              ),
            child: Container(
              decoration: BoxDecoration(
                color: (animation.value < halfAngle && first) || (!first && animation.value == 0.0)
                    ? AppColors.daintree
                    : AppColors.blueStone,
                borderRadius: const BorderRadius.all(
                  Radius.circular(
                    AppDimensions.d16,
                  ),
                ),
              ),
              child: (first && animation.value < halfAngle ||
                      (animation.value == 0.0 && !hasLastChild))
                  ? child
                  : lastChild,
            ),
          );
  }
}
