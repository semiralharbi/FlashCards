import '../../../theme/global_imports.dart';

class FolderListTile extends StatelessWidget {
  const FolderListTile({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) => Container(
        constraints: const BoxConstraints(minHeight: AppDimensions.d68),
        margin: const EdgeInsets.symmetric(
          vertical: AppDimensions.d10,
          horizontal: AppDimensions.d4,
        ),
        decoration: const BoxDecoration(
          color: AppColors.whiteSmoke,
          borderRadius: BorderRadius.all(
            Radius.circular(
              AppDimensions.d8,
            ),
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: AppDimensions.d4,
              offset: Offset(1, 1.5),
              color: AppColors.daintree,
            ),
          ],
        ),
        child: child?.animate().fadeIn(
              delay: 300.ms,
              duration: 800.ms,
              curve: Curves.easeIn,
            ),
      );
}
