import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../domain/entities/words/everything_entity.dart';
import '../../../injectable/injectable.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_dimensions.dart';
import '../../utils/enums/context_extension.dart';
import '../../utils/enums/errors.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/app_snackbar.dart';
import '../../widgets/custom_drawer/custom_drawer.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/progress_indicator.dart';
import 'cubit/dictionary_cubit.dart';
import 'cubit/dictionary_state.dart';
import 'widgets/dictionary_container.dart';

@RoutePage()
class DictionaryPage extends StatelessWidget {
  const DictionaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      safeAreaMinimum: const EdgeInsets.symmetric(
        horizontal: AppDimensions.d16,
        vertical: AppDimensions.d10,
      ),
      appBarTitle: context.tr.dictionary,
      onlyBottomWood: true,
      drawer: const CustomDrawer(),
      child: BlocProvider(
        create: (context) => getIt<DictionaryCubit>(),
        child: BlocConsumer<DictionaryCubit, DictionaryState>(
          listener: (context, state) => state.maybeWhen(
            failure: (error) => showAppSnackBar(
              context,
              error.errorText(context),
            ),
            orElse: () => null,
          ),
          builder: (context, state) => state.maybeWhen(
            orElse: () => const _StableBody(),
            loading: () => const _StableBody(
              centeredChild: true,
              child: AppProgressIndicator(
                color: AppColors.daintree,
              ),
            ),
            success: (entity) => _StableBody(child: _WordInfo(entity: entity)),
          ),
        ),
      ),
    );
  }
}

class _StableBody extends HookWidget {
  const _StableBody({
    this.child,
    this.centeredChild = false,
  });

  final Widget? child;
  final bool centeredChild;

  @override
  Widget build(BuildContext context) {
    final textFieldController = useTextEditingController();
    return Column(
      children: [
        CustomTextField(
          controller: textFieldController,
          hintText: context.tr.enterWord,
          suffixIcon: IconButton(
            padding: const EdgeInsets.only(
              right: AppDimensions.d10,
            ),
            icon: const Icon(
              Icons.search,
              color: AppColors.daintree,
            ),
            onPressed: () => context.read<DictionaryCubit>().searchWord(
                  textFieldController.text,
                ),
          ),
        ),
        if (centeredChild) const Spacer(),
        child ?? const SizedBox.shrink(),
        if (centeredChild) const Spacer(),
      ],
    );
  }
}

class _WordInfo extends HookWidget {
  const _WordInfo({
    required this.entity,
  });
  final EverythingEntity entity;

  @override
  Widget build(BuildContext context) => Expanded(
        child: PageView.builder(
          itemCount: entity.results?.length,
          itemBuilder: (context, index) => DictionaryContainer(
            actualIndex: index + 1,
            listLength: entity.results?.length ?? 0,
            definition: entity.results?[index].definition,
            partOfSpeech: entity.results?[index].partOfSpeech,
            synonyms: entity.results?[index].synonyms,
            typeOf: entity.results?[index].typeOf,
          ),
        ),
      );
}
