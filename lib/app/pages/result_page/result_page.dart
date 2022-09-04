import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_dimensions.dart';
import '../../theme/app_paths.dart';
import '../../utils/translation/generated/l10n.dart';
import '../../widgets/app_elevated_button.dart';
import '../../widgets/app_scaffold.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBarTitle: Translation.of(context).yourScore,
      child: Column(
        children: [
          const SizedBox(height: AppDimensions.d80),
          Padding(
            padding: const EdgeInsets.all(AppDimensions.d20),
            child: Text(
              Translation.of(context).congratulation,
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: AppDimensions.d28,
                    color: AppColors.daintree,
                  ),
            ),
          ),
          const SizedBox(height: AppDimensions.d50),
          Center(
            child: Image.asset(
              AppPaths.monkeyDeaf,
              height: AppDimensions.d180,
            ),
          ),
          const SizedBox(height: AppDimensions.d40),
          Column(
            children: [
              Text(
                Translation.of(context).yourScore,
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: AppDimensions.d20,
                      color: AppColors.daintree,
                    ),
              ),
              const SizedBox(height: AppDimensions.d10),
              Text(
                '10/100',
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: AppDimensions.d28,
                      color: AppColors.salem,
                    ),
              ),
              const SizedBox(height: AppDimensions.d20),
              Row(
                children: [
                  SizedBox(
                    width: AppDimensions.d180,
                    child: AppElevatedButton(
                      text: Translation.of(context).startNextRound,
                      onPressed: () {},
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: AppDimensions.d180,
                    child: AppElevatedButton(
                      text: Translation.of(context).chooseOtherFolder,
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
