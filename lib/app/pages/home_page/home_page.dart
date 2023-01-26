import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../domain/entities/database/flashcard_entity.dart';
import '../../../injectable/injectable.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_dimensions.dart';
import '../../utils/enums/capitalize.dart';
import '../../utils/enums/errors.dart';
import '../../utils/router/app_router.gr.dart';
import '../../utils/translation/generated/l10n.dart';
import '../../widgets/alphabet_container.dart';
import '../../widgets/app_floating_action_button.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/app_snackbar.dart';
import '../../widgets/custom_dialog.dart';
import '../../widgets/custom_drawer/custom_drawer.dart';
import '../../widgets/custom_list_dialog/custom_list_dialog.dart';
import 'cubit/home_cubit.dart';
import 'cubit/home_state.dart';
import 'widgets/list_container.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => getIt<HomeCubit>(),
        child: BlocConsumer<HomeCubit, HomeState>(
          builder: (context, state) => state.maybeWhen(
            initial: (entity, failure) => _Body(
              entity: entity,
              failure: failure?.appError,
            ),
            orElse: () => const SizedBox.shrink(),
          ),
          listener: (context, state) => state.maybeWhen(
            orElse: () => null,
          ),
        ),
      );
}

class _Body extends HookWidget {
  const _Body({
    Key? key,
    this.entity,
    this.failure,
  }) : super(key: key);

  final List<FlashcardEntity>? entity;
  final Errors? failure;

  @override
  Widget build(BuildContext context) {
    final controller = useScrollController();
    final folderController = useTextEditingController();
    List<TextEditingController> enWordListControllers = [TextEditingController()];
    List<TextEditingController> translatedListControllers = [TextEditingController()];
    final currentLetter = useState('A');

    /// has to be set to A for the first bolded character
    final letters = useState<List<String>>([]);

    if (entity != null) {
      useEffect(
        () {
          /// Listen to the scroll position of the folders ListView and updates the currentLetter to be bolded
          controller.addListener(() {
            double position = controller.offset / AppDimensions.d86;
            int index = position.floor();
            if (index >= 0 && index < entity!.length) {
              final letter = entity![index].folderName[0].toUpperCase();
              if (letter != currentLetter.value) {
                currentLetter.value = letter;
              }
            }
          });
          return null;
        },
        [controller],
      );

      ///Create and memoized the uniqueLetters from entity list, for performance improvement
      letters.value = useMemoized(
        () {
          final uniqueLetters = <String>{};
          for (int i = 0; i < entity!.length; i++) {
            uniqueLetters.add(entity![i].folderName[0].toUpperCase());
          }
          return uniqueLetters.toList();
        },
        [entity],
      );
    }
    return AppScaffold(
      onlyBottomWood: true,
      drawer: const CustomDrawer(),
      enableBackArrow: false,
      floatingActionButton: AppFloatingActionButton(
        onPressed: () async {
          showDialog(
            context: context,
            builder: (dialogContext) => CustomDialog(
              controller: folderController,
              onTap: () async {
                    await dialogContext.router.pop(true);
                  },
                ),
          ).then((value) {
            value != null
                ? showDialog(
              context: context,
              builder: (secondDialogContext) => BlocProvider<HomeCubit>.value(
                value: context.read<HomeCubit>(),
                child: CustomListDialog(
                  enWordListControllers: enWordListControllers,
                  translatedListControllers: translatedListControllers,
                  onForwardTap: () async {
                    await context.read<HomeCubit>().createFolder(
                      folderName: folderController.text,
                      enWordsList: enWordListControllers.map((e) => e.text).toList(),
                      translatedWordsList:
                      translatedListControllers.map((e) => e.text).toList(),
                    );
                          folderController.clear();
                          await secondDialogContext.router.pop();
                        },
                      ),
                    ),
                  )
                : null;
          });
        },
      ),
      child: entity != null && entity!.isNotEmpty
          ? Row(
              children: [
                Expanded(
                  child: ListView.builder(
                    physics: const ClampingScrollPhysics(),
                    itemCount: letters.value.length,
                    itemBuilder: (context, index) => AlphabetContainer(
                      onPressed: () {
                        int value = 0;
                        for (int i = 0; i < entity!.length; i++) {
                          if (entity![i].folderName[0].toUpperCase() == letters.value[index]) {
                            value = i;
                            break;
                          }
                        }
                        controller.jumpTo(value * AppDimensions.d86);
                        currentLetter.value = letters.value[index];
                      },
                      textStyleCondition: letters.value[index] == currentLetter.value,
                      text: letters.value[index],
                    ),
                  ),
                ),
                const SizedBox(
                  width: AppDimensions.d10,
                ),
                Expanded(
                  flex: 10,
                  child: ListView.builder(
                    padding: const EdgeInsets.only(bottom: AppDimensions.d46),
                    controller: controller,
                    itemCount: entity?.length,
                    itemBuilder: (context, index) => ListContainer(
                      onTap: () => context.router.push(
                        FolderContentRoute(
                          flashcardEntity: entity![index],
                        ),
                      ),
                      key: UniqueKey(),
                      onDismissed: (_) {
                        context.read<HomeCubit>().deleteFolder(
                              entity![index],
                            );
                        showAppSnackBar(
                          context,
                          Translation.of(context)
                              .folderDelete(entity![index].folderName.capitalize()),
                        );
                      },
                      entityElement: entity?[index],
                    ),
                  ),
                ),
              ],
            )
          : Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.d16,
                ),
                child: Text(
                  failure?.errorText(context) ?? '',
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: AppDimensions.d14,
                        color: AppColors.daintree,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
    );
  }
}
