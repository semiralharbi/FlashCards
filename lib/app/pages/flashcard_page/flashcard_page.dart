import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../domain/entities/database/flashcard_entity.dart';
import '../../../domain/entities/database/words_entity.dart';
import '../../../injectable/injectable.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_dimensions.dart';
import '../../theme/app_paths.dart';
import '../../theme/consts.dart';
import '../../utils/router/app_router.dart';
import '../../utils/translation/generated/l10n.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/custom_drawer/custom_drawer.dart';
import '../../widgets/flashcard_container.dart';
import '../../widgets/rounded_icon_button.dart';
import 'cubit/flashcard_cubit.dart';
import 'cubit/flashcard_state.dart';

class FlashcardPage extends StatelessWidget {
  const FlashcardPage({
    Key? key,
    required this.flashcardEntity,
    required this.index,
    this.newEntityList,
  }) : super(key: key);

  final FlashcardEntity flashcardEntity;
  final List<WordsEntity>? newEntityList;
  final int index;

  @override
  Widget build(BuildContext context) => AppScaffold(
        appBarTitle: Translation.of(context).flashcard,
        drawer: const CustomDrawer(),
        onlyBottomWood: true,
        child: BlocProvider(
          create: (context) => getIt<FlashcardCubit>(),
          child: BlocConsumer<FlashcardCubit, FlashcardState>(
            listener: (context, state) => state.maybeWhen(
              next: (wordsEntity, index) => context.router.push(
                FlashcardRoute(
                  flashcardEntity: flashcardEntity,
                  newEntityList: wordsEntity,
                  index: index,
                ),
              ),
              orElse: () => const SizedBox.shrink(),
            ),
            builder: (context, state) {
              return _Body(
                flashcardEntity: flashcardEntity,
                index: index,
                newEntityList: newEntityList,
              );
            },
          ),
        ),
      );
}

class _Body extends HookWidget {
  const _Body({
    Key? key,
    required this.flashcardEntity,
    required this.index,
    this.newEntityList,
  }) : super(key: key);

  final FlashcardEntity flashcardEntity;
  final List<WordsEntity>? newEntityList;
  final int index;

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(
      duration: const Duration(milliseconds: AppConst.milliseconds600),
    );
    final animation = useAnimation(controller);
    final isAnimationCompleted = animation > 0;
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
                  text: flashcardEntity.words[index].enWord,
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
                      AppPaths.monkeyBlind,
                      fit: BoxFit.scaleDown,
                      scale: AppDimensions.d3,
                    ),
                  ),
                  animation:
                  Tween<double>(begin: AppConst.staticZero, end: AppDimensions.d90).animate(
                    CurvedAnimation(
                      parent: controller,
                      curve: const Interval(AppConst.staticZero, 0.6),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        FlashcardContainer(text: flashcardEntity.words[index].translatedWord),
        const Spacer(),
        AnimatedSwitcher(
          duration: const Duration(
            milliseconds: AppConst.millisecond400,
          ),
          transitionBuilder: (child, animation) => AbsorbPointer(
            absorbing: animation.status == AnimationStatus.forward,
            child: ScaleTransition(
              scale: animation,
              child: child,
            ),
          ),
          child: isAnimationCompleted
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RoundedIconButton(
                      elementHeight: AppDimensions.d24,
                      stringPath: AppPaths.close,
                      buttonColor: AppColors.whiteSmoke,
                      iconColor: AppColors.daintree,
                      onTap: () => context.read<FlashcardCubit>().next(
                            entity: flashcardEntity,
                            controller: controller,
                            index: index,
                            isCorrect: false,
                            newEntityList: newEntityList,
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
                            entity: flashcardEntity,
                            controller: controller,
                            index: index,
                            isCorrect: true,
                            newEntityList: newEntityList,
                          ),
                    ),
                  ],
                )
              : Padding(
                  padding: const EdgeInsets.only(
                    bottom: AppDimensions.d22,
                  ),
                  child: Text(
                    Translation.of(context).guessHiddenWordDesc,
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          color: AppColors.daintree,
                          fontWeight: FontWeight.w500,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
        )
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
  final double fullAngle = AppDimensions.d180;
  final double halfAngle = AppDimensions.d180 / AppDimensions.d2;

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
