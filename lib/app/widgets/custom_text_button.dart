import '../theme/global_imports.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({super.key, required this.action, required this.text});

  final VoidCallback action;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: action,
      child: Text(
        text,
        style: context.tht.titleMedium,
      ),
    );
  }
}
