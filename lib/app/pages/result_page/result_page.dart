import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/database/flashcard_entity.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_dimensions.dart';
import '../../theme/app_paths.dart';
import '../../utils/enums/context_extension.dart';
import '../../utils/router/app_router.dart';
import '../../widgets/app_elevated_button.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/custom_drawer/custom_drawer.dart';

@RoutePage()
class ResultPage extends StatelessWidget {
  const ResultPage({
    Key? key,
    required this.entity,
  }) : super(key: key);
  final FlashcardEntity entity;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      drawer: const CustomDrawer(),
      appBarTitle: context.tr.yourScore,
      child: Column(
        children: [
          const Spacer(),
          Text(
            context.tr.congratulation,
            style: context.tht.titleSmall?.copyWith(
              fontSize: AppDimensions.d24,
              color: AppColors.daintree,
            ),
          ),
          const Spacer(),
          Center(
            child: Image.asset(
              AppPaths.monkeyDeaf,
              height: AppDimensions.d146,
            ),
          ),
          const Spacer(),
          Column(
            children: [
              Text(
                context.tr.answeredRight,
                style: context.tht.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.daintree,
                ),
              ),
              const SizedBox(height: AppDimensions.d10),
              Text(
                '${entity.correctAnswers}/${entity.words.length}',
                style: context.tht.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: AppDimensions.d28,
                  color: AppColors.salem,
                ),
              ),
              const SizedBox(height: AppDimensions.d20),
              Row(
                children: [
                  SizedBox(
                    width: context.mqs.width * 0.36,
                    child: AppElevatedButton(
                      text: context.tr.retry,
                      onPressed: () => context.router.replace(
                        FolderContentRoute(
                          flashcardEntity: entity,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: context.mqs.width * 0.36,
                    child: AppElevatedButton(
                      text: context.tr.chooseOtherFolder,
                      onPressed: () => context.router.replace(
                        const HomeRoute(),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
