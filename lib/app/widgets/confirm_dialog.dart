import '../theme/global_imports.dart';
import 'app_floating_action_button.dart';

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({
    super.key,
    required this.onPressed,
    required this.child,
    required this.information,
  });

  final VoidCallback onPressed;
  final Widget child;
  final String information;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: AppDimensions.d152, left: AppDimensions.d20, right: AppDimensions.d20, bottom: AppDimensions.d152),
      child: Dialog(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.d4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Gap(AppDimensions.d20),
              Padding(
                padding: const EdgeInsets.all(AppDimensions.d8),
                child: child,
              ),
              const Gap(10),
              Padding(
                padding: const EdgeInsets.all(AppDimensions.d8),
                child: Text(
                  information,
                  textAlign: TextAlign.center,
                  style: context.tht.bodySmall,
                ),
              ),
              const Gap(AppDimensions.d10),
              Padding(
                padding: const EdgeInsets.all(AppDimensions.d8),
                child: AppFloatingActionButton(
                  onPressed: onPressed,
                  icon: Icons.check,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
