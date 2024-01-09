import '../theme/global_imports.dart';
import 'app_floating_action_button.dart';
import 'custom_text_field.dart';

class CustomDialogWithTextField extends StatelessWidget {
  const CustomDialogWithTextField({super.key, required this.controller, required this.onPressed});

  final TextEditingController controller;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: 400,
        height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Gap(20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextField(
                textFieldPadding: EdgeInsets.zero,
                controller: controller,
                hintText: 'wpisz email do zresetowania hasła',
              ),
            ),
            const Gap(10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Po zatwierdzeniu przyciskiem, otrzymasz na podanego maila link do zresetowania hasła',
                textAlign: TextAlign.center,
                style: context.tht.bodySmall,
              ),
            ),
            const Gap(10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppFloatingActionButton(onPressed: onPressed),
            ),
          ],
        ),
      ),
    );
  }
}
