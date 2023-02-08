import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_dimensions.dart';
import '../../theme/app_paths.dart';
import '../../utils/enums/context_extension.dart';
import '../../widgets/app_elevated_button.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/custom_drawer/custom_drawer.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({Key? key}) : super(key: key);

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
            style: context.tht.subtitle2!.copyWith(
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
                style: context.tht.subtitle1!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.daintree,
                ),
              ),
              const SizedBox(height: AppDimensions.d10),
              Text(
                '10/100',
                style: context.tht.subtitle1!.copyWith(
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
                      text: context.tr.startNextRound,
                      onPressed: () {},
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: context.mqs.width * 0.36,
                    child: AppElevatedButton(
                      text: context.tr.chooseOtherFolder,
                      onPressed: () {},
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
