import '../theme/global_imports.dart';

class AlphabetContainer extends StatelessWidget {
  const AlphabetContainer({
    super.key,
    required this.onPressed,
    required this.isSelectedLetter,
    required this.text,
  });

  final VoidCallback onPressed;
  final bool isSelectedLetter;
  final String text;

  @override
  Widget build(BuildContext context) => TextButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                AppDimensions.d44,
              ),
            ),
          ),
          minimumSize: MaterialStateProperty.all<Size?>(
            const Size(
              AppDimensions.d10,
              AppDimensions.d10,
            ),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: context.tht.titleMedium?.copyWith(
            fontWeight: isSelectedLetter ? FontWeight.w800 : FontWeight.w600,
            fontSize: isSelectedLetter ? AppDimensions.d18 : AppDimensions.d14,
          ),
        ),
      );
}
