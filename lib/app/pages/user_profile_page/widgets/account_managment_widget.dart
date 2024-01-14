import '../../../theme/global_imports.dart';
import '../../../widgets/confirm_dialog.dart';
import '../../../widgets/custom_text_field.dart';
import '../cubit/user_profile_cubit.dart';

class AccountManagement extends StatelessWidget {
  const AccountManagement({
    super.key,
    required this.email,
    required this.controller,
  });

  final String email;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.d8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppDimensions.d8),
            child: TextButton(
              onPressed: () => context.read<UserProfileCubit>().onSignOutButton(),
              child: Text(
                context.tr.userProfilePage_logoutButton,
                style: context.tht.titleMedium,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppDimensions.d8),
            child: TextButton(
              onPressed: () => showDialog(
                context: context,
                builder: (_) => ConfirmDialog(
                  onPressed: () {
                    context.read<UserProfileCubit>().onResetPassword(email);
                    context.router.pop();
                  },
                  information: context.tr.userProfilePage_changePasswordDialogInformation,
                  child: CustomTextField(
                    textFieldPadding: EdgeInsets.zero,
                    controller: controller,
                    hintText: context.tr.userProfilePage_writeDownYourEmail,
                  ),
                ),
              ),
              child: Text(
                context.tr.userProfilePage_changePasswordButton,
                style: context.tht.titleMedium,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppDimensions.d8),
            child: TextButton(
              onPressed: () => showDialog(
                context: context,
                builder: (_) => ConfirmDialog(
                  onPressed: () {
                    context.read<UserProfileCubit>().onDeleteAccount();
                  },
                  information: context.tr.userProfilePage_deleteAccount,
                  child: Text(context.tr.userProfilePage_deleteAccount),
                ), /**/
              ),
              child: Text(
                context.tr.userProfilePage_deleteAccount,
                style: context.tht.titleMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
