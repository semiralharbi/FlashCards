import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../domain/entities/database/words_entity.dart';
import '../../../injectable/injectable.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_dimensions.dart';
import '../../theme/app_paths.dart';
import '../../utils/router/app_router.dart';
import '../../utils/translation/generated/l10n.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/custom_drawer/custom_drawer.dart';
import '../../widgets/flashcard_container.dart';
import '../../widgets/rounded_icon_button.dart';
import 'cubit/flashcard_cubit.dart';
import 'cubit/flashcard_state.dart';

class FlashcardPage extends HookWidget {
  const FlashcardPage({
    Key? key,
    required this.wordsEntity,
    required this.index,
  }) : super(key: key);

  final List<WordsEntity> wordsEntity;
  final int index;

  @override
  Widget build(BuildContext context) {
    final _controller = useAnimationController(
      duration: const Duration(milliseconds: 600),
    );
    return AppScaffold(
      appBarTitle: Translation.of(context).flashcard,
      drawer: const CustomDrawer(),
      onlyBottomWood: true,
      child: BlocProvider(
        create: (context) => getIt<FlashcardCubit>(),
        child: BlocConsumer<FlashcardCubit, FlashcardState>(
          listener: (context, state) => state.maybeWhen(
            next: (wordsEntity, index) => context.router.push(
              FlashcardRoute(
                wordsEntity: wordsEntity,
                index: index,
              ),
            ),
            orElse: () => const SizedBox.shrink(),
          ),
          builder: (context, state) {
            return _Body(
              controller: _controller,
              wordsEntity: wordsEntity,
              index: index,
            );
          },
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    Key? key,
    required this.controller,
    required this.wordsEntity,
    required this.index,
  }) : super(key: key);

  final AnimationController controller;
  final List<WordsEntity> wordsEntity;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.3,
          child: Stack(
            fit: StackFit.expand,
            children: [
              GestureDetector(
                onTap: () => context.read<FlashcardCubit>().animate(controller),
                child: FlashcardContainer(
                  text: wordsEntity[index].enWord,
                ),
              ),
              GestureDetector(
                onTap: () => context.read<FlashcardCubit>().animate(controller),
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
                      AppPaths.monkey,
                      fit: BoxFit.scaleDown,
                      scale: 3,
                    ),
                  ),
                  animation: Tween<double>(begin: 0.0, end: 90.0).animate(
                    CurvedAnimation(
                      parent: controller,
                      curve: const Interval(0.0, 0.6),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        const Spacer(),
        FlashcardContainer(text: wordsEntity[index].translatedWord),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            RoundedIconButton(
              elementHeight: AppDimensions.d24,
              stringPath: AppPaths.close,
              buttonColor: AppColors.whiteSmoke,
              iconColor: AppColors.daintree,
              onTap: () => context.read<FlashcardCubit>().next(
                    entity: wordsEntity,
                    controller: controller,
                    index: index,
                    isCorrect: false,
                  ),
            ),
            const SizedBox(
              width: AppDimensions.d26,
            ),
            RoundedIconButton(
              elementHeight: AppDimensions.d44,
              iconData: Icons.check,
              padding: const EdgeInsets.all(AppDimensions.d8),
              onTap: () => context.read<FlashcardCubit>().next(
                    entity: wordsEntity,
                    controller: controller,
                    index: index,
                    isCorrect: true,
                  ),
            ),
          ],
        ),
        const Spacer(
          flex: 2,
        ),
      ],
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
