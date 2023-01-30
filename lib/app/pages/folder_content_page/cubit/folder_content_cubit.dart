import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/entities/database/flashcard_entity.dart';
import '../../../../domain/use_case/delete_word_use_case.dart' as delete_word;
import '../../../../domain/use_case/get_collections_use_case.dart';
import '../../../theme/consts.dart';
import 'folder_content_state.dart';

@injectable
class FolderContentCubit extends Cubit<FolderContentState> {
  FolderContentCubit(this._deleteWordUseCase, this._getCollectionsUseCase)
      : super(const FolderContentState.initial());

  final delete_word.DeleteWordUseCase _deleteWordUseCase;
  final GetCollectionsUseCase _getCollectionsUseCase;

  Future<void> init(FlashcardEntity entity) async {
    final result = await _getCollectionsUseCase();
    result.fold(
      //TODO:Implement Error
      (l) => null,
      (r) => emit(
        FolderContentState.reload(
          r.firstWhere((element) => element.folderName == entity.folderName),
        ),
      ),
    );
  }

  void animate(AnimationController controller, ValueNotifier<bool> onChange) {
    if (controller.isAnimating == false) {
      if (controller.isCompleted) {
        controller.animateBack(
          AppConst.staticZero,
          duration: const Duration(
            milliseconds: AppConst.milliseconds200,
          ),
        );
        onChange.value = false;
      } else {
        controller.forward();
        onChange.value = true;
      }
    }
  }

  Future<void> deleteWord(FlashcardEntity entity, int index) async {
    final result = await _deleteWordUseCase(delete_word.Params(index, entity));
    result.fold(
      //TODO: Implement error
      (l) => l,
      (r) => init(entity),
    );
  }

  void nextPage(FlashcardEntity entity) {
    const int index = 0;
    emit(FolderContentState.nextPage(entity, index));
    emit(const FolderContentState.initial());
  }
}
