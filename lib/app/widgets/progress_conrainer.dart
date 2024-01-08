import '../theme/global_imports.dart';

class ProgressContainer extends StatelessWidget {
  const ProgressContainer({super.key, required this.information, required this.progress});

  final String information;
  final int progress;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        alignment: Alignment.center,
        constraints: const BoxConstraints(minHeight: AppDimensions.d80),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              alignment: Alignment.center,
              constraints: const BoxConstraints(minHeight: AppDimensions.d80),
              decoration: BoxDecoration(
                color: AppColors.buttonInactive,
                borderRadius: BorderRadius.circular(10),
              ),
              width: AppDimensions.d86,
              child: Text(
                progress.toString(),
                style: context.tht.titleMedium,
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              alignment: Alignment.center,
              constraints: const BoxConstraints(maxWidth: 120),
              child: Text(
                information,
                style: context.tht.labelSmall,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
