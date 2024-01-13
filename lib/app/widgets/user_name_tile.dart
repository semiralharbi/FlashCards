import '../theme/global_imports.dart';

class UserNameTile extends StatelessWidget {
  const UserNameTile({super.key, required this.userName, required this.child});

  final String userName;
  final Widget child;

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
            child: child,
          ),
        ],
      ),
    );
  }
}
