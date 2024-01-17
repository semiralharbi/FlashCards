import '../theme/global_imports.dart';
import 'app_snackbar.dart';
import 'custom_text_field.dart';

class CreateFolderDialog extends StatelessWidget {
  const CreateFolderDialog({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) => AlertDialog(
        backgroundColor: AppColors.whiteSmoke,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Gap(AppDimensions.d20),
            CustomTextField(
              textFieldPadding: EdgeInsets.zero,
              controller: controller,
              hintText: context.tr.folderName,
              suffixIcon: const Icon(
                Icons.folder_open,
                size: AppDimensions.d36,
                color: AppColors.daintree,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            child: Text(
              context.tr.cancel,
              style: context.tht.titleMedium,
            ),
            onPressed: () => _onCancelPressed(context),
          ),
          TextButton(
            child: Text(
              context.tr.create,
              style: context.tht.titleMedium,
            ),
            onPressed: () => _onCreatePressed(context),
          ),
        ],
      );

  void _onCreatePressed(BuildContext context) {
    if (controller.text.isEmpty) {
      showAppSnackBar(context, context.tr.folderNameError);
      return;
    }
    context.router.pop(true);
  }

  void _onCancelPressed(BuildContext context) {
    controller.clear();
    context.router.pop(false);
  }
}
