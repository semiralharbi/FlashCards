import '../../../theme/global_imports.dart';

class DismissibleBackground extends StatelessWidget {
  const DismissibleBackground({super.key});

  @override
  Widget build(BuildContext context) => Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(
          right: AppDimensions.d12,
        ),
        decoration: const BoxDecoration(
          color: AppColors.milanoRed,
          borderRadius: BorderRadius.all(
            Radius.circular(AppDimensions.d8),
          ),
        ),
        child: const Icon(
          Icons.delete_forever_rounded,
          size: AppDimensions.d36,
          color: AppColors.whiteSmoke,
        ),
      );
}
