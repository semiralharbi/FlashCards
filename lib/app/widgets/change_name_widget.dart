import '../theme/global_imports.dart';

class RefactorInformationWidget extends StatelessWidget {
  const RefactorInformationWidget({
    super.key,
    required this.text,
    required this.approveButton,
    required this.cancelButton,
  });

  final Widget text;
  final IconButton approveButton;
  final IconButton cancelButton;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(child: text),
        approveButton,
        cancelButton,
      ],
    );
  }
}
