import '../../../theme/global_imports.dart';

class UserNameHeader extends StatelessWidget {
  const UserNameHeader({
    super.key,
    required this.userName,
    required this.onEditonTap,
  });

  final String userName;
  final VoidCallback onEditonTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDimensions.d26),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              userName,
              style: context.tht.labelLarge,
              textAlign: TextAlign.start,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: AppDimensions.d10),
            child: GestureDetector(
              onTap: onEditonTap,
              child: const Icon(Icons.draw_outlined),
            ),
          ),
        ],
      ),
    );
  }
}
