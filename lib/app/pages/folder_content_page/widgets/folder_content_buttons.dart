import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injectable/injectable.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_dimensions.dart';
import '../../../utils/translation/generated/l10n.dart';
import '../cubit/folder_content_cubit.dart';

class FolderContentButtons extends StatelessWidget {
  const FolderContentButtons({
    Key? key,
    required this.animationController,
    required this.onChange,
    required this.onPressed,
  }) : super(key: key);

  final AnimationController animationController;
  final ValueNotifier<bool> onChange;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => getIt<FolderContentCubit>(),
        child: _Body(
          onPressed: onPressed,
          animationController: animationController,
          onChange: onChange,
        ),
      );
}

class _Body extends StatelessWidget {
  const _Body({
    Key? key,
    required this.onPressed,
    required this.animationController,
    required this.onChange,
  }) : super(key: key);

  final VoidCallback onPressed;
  final AnimationController animationController;
  final ValueNotifier<bool> onChange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: AppDimensions.d64,
      ),
      child: Row(
        children: [
          Material(
            elevation: AppDimensions.d8,
            borderRadius: const BorderRadius.all(
              Radius.circular(
                AppDimensions.d8,
              ),
            ),
            child: SizedBox(
              width: AppDimensions.d166,
              height: AppDimensions.d40,
              child: ElevatedButton(
                onPressed: onPressed,
                child: Text(
                  Translation.of(context).startFlashcard,
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: AppDimensions.d14,
                        color: AppColors.daintree,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          const Spacer(),
          Material(
            elevation: AppDimensions.d8,
            borderRadius: const BorderRadius.all(
              Radius.circular(
                AppDimensions.d8,
              ),
            ),
            child: SizedBox(
              height: AppDimensions.d40,
              child: ElevatedButton(
                onPressed: () => context.read<FolderContentCubit>().animate(
                      animationController,
                      onChange,
                    ),
                child: Text(
                  onChange.value
                      ? Translation.of(context).hideAnswers
                      : Translation.of(context).uncoverAnswers,
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: AppDimensions.d14,
                        color: AppColors.daintree,
                      ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
