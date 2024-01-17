import '../../../theme/global_imports.dart';
import '../../../widgets/choice_dialog.dart';
import '../cubit/user_profile_cubit.dart';

class AccountSection extends StatefulWidget {
  const AccountSection({super.key});

  @override
  State<AccountSection> createState() => _AccountSectionState();
}

class _AccountSectionState extends State<AccountSection> {
  late final TextEditingController _changePasswordController;

  @override
  void initState() {
    super.initState();
    _changePasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _changePasswordController.dispose();
    super.dispose();
  }

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
                builder: (_) => ChoiceDialog(
                  controller: _changePasswordController,
                  descriptionText: context.tr.userProfilePage_changePasswordDialogInformation,
                  acceptButtonText: context.tr.userProfilePage_resetPassword,
                  onAcceptPressed: () =>
                      context.read<UserProfileCubit>().onResetPassword(_changePasswordController.text),
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
                builder: (_) => ChoiceDialog(
                  descriptionText: context.tr.userProfilePage_areYouSureYourDecision,
                  acceptButtonText: context.tr.userProfilePage_deleteAccount,
                  onAcceptPressed: () => context.read<UserProfileCubit>().onDeleteAccount(),
                ),
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
