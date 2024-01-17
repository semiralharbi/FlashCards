import '../theme/global_imports.dart';

class ChoiceDialog extends StatelessWidget {
  const ChoiceDialog({
    super.key,
    this.controller,
    this.onCancelPressed,
    required this.descriptionText,
    required this.acceptButtonText,
    required this.onAcceptPressed,
    this.cancelButtonText,
    this.acceptButtonColor = AppColors.white,
  });

  final TextEditingController? controller;
  final VoidCallback? onCancelPressed;
  final VoidCallback onAcceptPressed;
  final String descriptionText;
  final String acceptButtonText;
  final String? cancelButtonText;
  final Color acceptButtonColor;

  @override
  Widget build(BuildContext context) => AlertDialog(
        backgroundColor: AppColors.whiteSmoke,
        content: Padding(
          padding: const EdgeInsets.all(AppDimensions.d16),
          child: SizedBox(
            child: Text(
              descriptionText,
              style: context.tht.titleSmall,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              onCancelPressed?.call();
              context.router.pop();
            },
            child: Text(
              cancelButtonText ?? context.tr.confirmDialog_cancel,
              style: context.tht.titleMedium,
            ),
          ),
          TextButton(
            style: context.th.textButtonTheme.style?.copyWith(
              backgroundColor: MaterialStatePropertyAll(acceptButtonColor),
            ),
            onPressed: () {
              onAcceptPressed.call();
              context.router.pop();
            },
            child: Text(
              acceptButtonText,
              style: context.tht.titleMedium?.copyWith(color: AppColors.red),
            ),
          ),
        ],
      );
}
