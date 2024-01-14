import '../../../../domain/entities/user/user_profile_entity.dart';
import '../../../theme/global_imports.dart';
import '../cubit/user_profile_cubit.dart';

class ChangeUserNameTile extends StatelessWidget {
  const ChangeUserNameTile({
    super.key,
    required this.textField,
    required this.nameController,
    required this.function,
  });

  final TextEditingController nameController;
  final Widget textField;
  final VoidCallback function;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: textField,
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppDimensions.d3),
              child: GestureDetector(
                onTap: () {
                  context.read<UserProfileCubit>().onUpdateUserProfileButton(
                        entity: UserProfileEntity(
                          name: nameController.text,
                        ),
                      );
                  function;
                },
                child: const Icon(Icons.check),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppDimensions.d3),
              child: GestureDetector(
                onTap: () {
                  context.router.pop();
                  function;
                },
                child: const Icon(Icons.cancel),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
