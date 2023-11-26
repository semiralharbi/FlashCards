import '../../../domain/entities/database/flashcard_entity.dart';
import '../../../injectable/injectable.dart';
import '../../theme/global_imports.dart';
import '../../utils/enums/errors.dart';
import '../../utils/enums/string_extensions.dart';
import '../../utils/translation/generated/l10n.dart';
import '../../widgets/app_floating_action_button.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/app_snackbar.dart';
import '../../widgets/custom_dialog.dart';
import '../../widgets/custom_drawer/custom_drawer.dart';
import '../../widgets/progress_indicator.dart';
import 'cubit/home_cubit.dart';
import 'cubit/home_state.dart';
import 'widgets/alphabet_letters.dart';
import 'widgets/empty_home_widget.dart';
import 'widgets/folder_container.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => getIt<HomeCubit>()..init(),
        child: BlocConsumer<HomeCubit, HomeState>(
          builder: (context, state) => state.maybeWhen(
            initial: (entity, failure) => _Body(
              entity: entity,
              failure: failure?.appError,
            ),
            loading: () => const AppScaffold(
              onlyBottomWood: true,
              enableBackArrow: false,
              child: AppProgressIndicator(
                color: AppColors.daintree,
              ),
            ),
            orElse: () => const _Body(
              failure: Errors.somethingWentWrong,
            ),
          ),
          listener: (context, state) => state.whenOrNull(
            fail: (error) => showAppSnackBar(
              context,
              error.errorText(context),
            ),
          ),
        ),
      );
}

class _Body extends StatefulWidget {
  const _Body({
    this.entity,
    this.failure,
  });

  final List<FlashcardEntity>? entity;
  final Errors? failure;

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  late final ScrollController controller;
  late final TextEditingController folderController;

  @override
  void initState() {
    super.initState();
    controller = ScrollController();
    folderController = TextEditingController();
  }

  Future<void> _onFloatingActionButtonTapped() async {
    final bool createFolder = await showDialog<bool>(
          useSafeArea: false,
          context: context,
          builder: (_) => CreateFolderDialog(controller: folderController),
        ) ??
        false;
    if (createFolder && mounted) {
      context.router.push(CreateFolderRoute(folderName: folderController.text));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      onlyBottomWood: true,
      drawer: const CustomDrawer(),
      enableBackArrow: false,
      floatingActionButton: AppFloatingActionButton(
        onPressed: _onFloatingActionButtonTapped,
      ),
      child: widget.entity != null && widget.entity!.isNotEmpty
          ? Row(
              children: [
                Expanded(
                  child: AlphabetLetters(
                    entity: widget.entity,
                    controller: controller,
                  ),
                ).animate(delay: 400.ms).fade().slide(curve: Curves.easeIn),
                const Gap(AppDimensions.d10),
                Expanded(
                  flex: 10,
                  child: ListView.builder(
                    padding: const EdgeInsets.only(bottom: AppDimensions.d46),
                    controller: controller,
                    itemCount: widget.entity?.length,
                    itemBuilder: (context, index) => FolderContainer(
                      onTap: () => context.router.push(
                        FolderContentRoute(
                          flashcardEntity: widget.entity![index],
                        ),
                      ),
                      key: UniqueKey(),
                      onDismissed: (_) {
                        context.read<HomeCubit>().deleteFolder(
                              widget.entity![index],
                            );
                        showAppSnackBar(
                          context,
                          Translation.of(context).folderDelete(widget.entity![index].folderName.capitalize()),
                        );
                      },
                      entityElement: widget.entity?[index],
                    ),
                  ),
                ).animate().fade().slideX(curve: Curves.easeIn),
              ],
            )
          : EmptyHomeWidget(failure: widget.failure),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    folderController.dispose();
    super.dispose();
  }
}
