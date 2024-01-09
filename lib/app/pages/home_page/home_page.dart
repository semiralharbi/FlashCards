import '../../../domain/entities/database/folder_entity.dart';
import '../../../injectable/injectable.dart';
import '../../theme/global_imports.dart';
import '../../utils/enums/errors.dart';
import '../../utils/enums/string_extensions.dart';
import '../../utils/translation/generated/l10n.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/app_snackbar.dart';
import '../../widgets/custom_drawer/custom_drawer.dart';
import '../../widgets/progress_indicator.dart';
import 'cubit/home_cubit.dart';
import 'cubit/home_state.dart';
import 'widgets/add_folder_action_button.dart';
import 'widgets/alphabet_letters.dart';
import 'widgets/empty_home_widget.dart';
import 'widgets/folder_container.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
    @visibleForTesting this.cubit,
  });

  final HomeCubit? cubit;

  @override
  Widget build(BuildContext context) => AppScaffold(
        onlyBottomWood: true,
        drawer: const CustomDrawer(
          title: 'Twoje teczki',
        ),
        enableBackArrow: false,
        floatingActionButton: const AddFolderActionButton(),
        child: BlocProvider<HomeCubit>(
          create: (context) => (cubit ?? getIt<HomeCubit>())..fetchFolders(),
          child: BlocConsumer<HomeCubit, HomeState>(
            builder: (context, state) => state.maybeWhen(
              loading: () => const AppProgressIndicator(color: AppColors.daintree),
              loaded: (folder) => _Body(folders: folder),
              empty: (error) => EmptyHomeWidget(text: error),
              orElse: () => const EmptyHomeWidget(text: Errors.somethingWentWrong),
            ),
            listener: (context, state) => state.whenOrNull(
              fail: (error) => showAppSnackBar(
                context,
                error.errorText(context),
              ),
            ),
          ),
        ),
      );
}

class _Body extends StatefulWidget {
  const _Body({required this.folders});

  final List<FolderEntity> folders;

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  late final ScrollController controller;

  @override
  void initState() {
    super.initState();
    controller = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AlphabetLetters(
            folders: widget.folders,
            controller: controller,
          ),
        ).animate(delay: 400.ms).fade().slide(curve: Curves.easeIn),
        const Gap(AppDimensions.d10),
        Expanded(
          flex: 10,
          child: ListView.builder(
            padding: const EdgeInsets.only(bottom: AppDimensions.d46),
            controller: controller,
            itemCount: widget.folders.length,
            itemBuilder: (context, index) => FolderContainer(
              onTap: () => context.router.push(
                FolderContentRoute(
                  folder: widget.folders[index],
                ),
              ),
              key: UniqueKey(),
              onDismissed: (_) {
                context.read<HomeCubit>().deleteFolder(
                      widget.folders[index],
                    );
                showAppSnackBar(
                  context,
                  Translation.of(context).folderDelete(widget.folders[index].folderName.capitalize()),
                );
              },
              folder: widget.folders[index],
            ),
          ),
        ).animate().fade().slideX(curve: Curves.easeIn),
      ],
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
