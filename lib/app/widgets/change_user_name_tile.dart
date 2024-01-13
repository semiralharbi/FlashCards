import '../theme/global_imports.dart';

class ChangeUserNameTile extends StatelessWidget {
  const ChangeUserNameTile(
      {super.key, required this.buttonToApprove, required this.textField, required this.buttonToPop});

  final Widget buttonToApprove;
  final Widget buttonToPop;
  final Widget textField;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          fit: FlexFit.tight,
          child: textField,
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppDimensions.d3),
              child: buttonToApprove,
            ),
            Padding(
              padding: const EdgeInsets.all(AppDimensions.d3),
              child: buttonToPop,
            ),
          ],
        ),
      ],
    );
  }
}
