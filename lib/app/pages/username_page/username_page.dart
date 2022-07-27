import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../injectable/injectable.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_dimensions.dart';
import '../../utils/enums/errors.dart';
import '../../utils/translation/generated/l10n.dart';
import '../../widgets/app_elevated_button.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/app_snackbar.dart';
import '../../widgets/progress_indicator.dart';
import '../../widgets/textfield_widget.dart';
import 'cubit/username_page_cubit.dart';
import 'cubit/username_page_state.dart';

class UsernamePage extends StatelessWidget {
  const UsernamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: BlocProvider(
        create: (context) => getIt<UsernamePageCubit>(),
        child: BlocConsumer<UsernamePageCubit, UsernamePageState>(
          listener: (context, state) => state.maybeWhen(
            loading: () => const AppProgressIndicator(),
            fail: (error) => error != null
                ? showAppSnackBar(
                    context,
                    error.errorText(context),
                  )
                : showAppSnackBar(
                    context,
                    Translation.of(context).unknownError,
                  ),
            orElse: () => const SizedBox.shrink(),
          ),
          builder: (context, state) => state.maybeWhen(
            success: () => const AppProgressIndicator(),
            initial: (username) => _Body(
              username: username,
            ),
            orElse: () => const SizedBox.shrink(),
          ),
        ),
      ),
    );
  }
}

class _Body extends HookWidget {
  const _Body({this.username});

  final String? username;

  @override
  Widget build(BuildContext context) {
    final usernameController = useTextEditingController(text: username);
    return Center(
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.whiteSmoke,
          borderRadius: BorderRadius.all(
            Radius.circular(
              AppDimensions.d16,
            ),
          ),
        ),
        height: MediaQuery.of(context).size.height / 1.6,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Text(
              Translation.of(context).welcomeUser,
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: AppDimensions.d18,
                    color: AppColors.cinnamon,
                  ),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            TextFieldWidget(
              controller: usernameController,
              hintText: Translation.of(context).username,
            ),
            const Spacer(flex: 2),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.d10,
              ),
              child: AppElevatedButton(
                onPressed: () => context
                    .read<UsernamePageCubit>()
                    .onUpdateButton(usernameController.text),
                text: Translation.of(context).logIn,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
