import '../theme/global_imports.dart';

class ProgressContainer extends StatelessWidget {
  const ProgressContainer({super.key, required this.information, required this.progress});

  final String information;
  final int progress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.d8),
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            decoration:  BoxDecoration(color:AppColors.buttonInactive, borderRadius: BorderRadius.circular(10)),
            width: AppDimensions.d80,
            height: AppDimensions.d80,
            child: Text(
              progress.toString(),
              style: context.tht.titleMedium,
              textAlign: TextAlign.center,
            ),
          ),
          Text(information, style: context.tht.titleSmall),
        ],
      ),
    );
  }
}
