import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../theme/global_imports.dart';

class WordsMatchProgressBar extends StatelessWidget {
  const WordsMatchProgressBar({
    super.key,
    required this.hasWords,
    required this.percent,
  });

  final bool hasWords;
  final double percent;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          hasWords ? '$percent%' : '-%',
          style: context.tht.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: AppDimensions.d12,
            color: AppColors.daintree,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        const Gap(AppDimensions.d6),
        LinearPercentIndicator(
          padding: EdgeInsets.zero,
          width: AppDimensions.d80,
          lineHeight: AppDimensions.d14,
          percent: hasWords ? percent : 0,
          backgroundColor: AppColors.altoDarker,
          progressColor: AppColors.salem,
          barRadius: const Radius.circular(AppDimensions.d16),
          animation: true,
          animationDuration: 1000,
        ),
      ],
    );
  }
}
