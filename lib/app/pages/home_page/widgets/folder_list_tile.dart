import '../../../theme/global_imports.dart';

class FolderListTile extends StatelessWidget {
  const FolderListTile({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) => Container(
        clipBehavior: Clip.hardEdge,
        constraints: const BoxConstraints(minHeight: AppDimensions.d68),
        margin: const EdgeInsets.symmetric(vertical: AppDimensions.d10),
        decoration: const BoxDecoration(
          color: AppColors.whiteSmoke,
          borderRadius: BorderRadius.all(
            Radius.circular(AppDimensions.d8),
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
              delay: 200.ms,
              duration: 600.ms,
              curve: Curves.easeIn,
            ),
      );
}
