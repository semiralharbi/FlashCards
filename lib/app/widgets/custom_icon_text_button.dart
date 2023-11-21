import '../theme/global_imports.dart';

class CustomIconTextButton extends StatelessWidget {
  const CustomIconTextButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.text,
  });

  final VoidCallback onPressed;
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: AppColors.daintree,
            size: AppDimensions.d32,
          ),
          const SizedBox(width: AppDimensions.d6),
          Flexible(
            child: Text(
              text,
              style: context.tht.titleMedium?.copyWith(
                fontSize: AppDimensions.d14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
