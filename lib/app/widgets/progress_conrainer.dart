import '../theme/global_imports.dart';

class ProgressContainer extends StatelessWidget {
  const ProgressContainer({super.key, required this.information, required this.progress});

  final String information;
  final int progress;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(6),
          constraints: const BoxConstraints(minHeight: AppDimensions.d80, maxWidth: 94),
          decoration: BoxDecoration(
            color: AppColors.buttonInactive,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Text(
                  progress.toString(),
                  style: context.tht.titleMedium,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        Text(
          information,
          style: context.tht.labelSmall,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
