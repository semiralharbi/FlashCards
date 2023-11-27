import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/database/folder_entity.dart';
import '../../../gen/assets.gen.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_dimensions.dart';
import '../../utils/enums/context_extension.dart';
import '../../utils/router/app_router.dart';
import '../../widgets/app_elevated_button.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/custom_drawer/custom_drawer.dart';

@RoutePage()
class ResultPage extends StatelessWidget {
  const ResultPage({
    super.key,
    required this.folder,
  });

  final FolderEntity folder;

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
              Assets.png.monkeyDeaf.path,
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
                '${folder.correctAnswers}/${folder.words.length}',
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
                          flashcardEntity: folder,
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
                        HomeRoute(),
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
