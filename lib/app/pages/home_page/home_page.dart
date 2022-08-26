import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../domain/entities/database/flashcard_entity.dart';
import '../../../injectable/injectable.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_dimensions.dart';
import '../../utils/enums/errors.dart';
import '../../utils/router/app_router.gr.dart';
import '../../widgets/app_floating_action_button.dart';
import '../../widgets/app_scaffold.dart';
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
    final folderController = useTextEditingController();
    List<TextEditingController> enWordListControllers = [TextEditingController()];
    List<TextEditingController> translatedListControllers = [TextEditingController()];
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
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.whiteSmoke,
          borderRadius: BorderRadius.all(
            Radius.circular(
              AppDimensions.d16,
            ),
          ),
        ),
        height: MediaQuery.of(context).size.height * 0.7,
        width: MediaQuery.of(context).size.width,
        child: entity != null && entity!.isNotEmpty
            ? ListView.builder(
                itemCount: entity?.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () =>
                      context.router.push(FolderContentRoute(flashcardEntity: entity![index])),
                  child: ListContainer(
                    entityElement: entity?[index],
                  ),
                ),
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
      ),
    );
  }
}
