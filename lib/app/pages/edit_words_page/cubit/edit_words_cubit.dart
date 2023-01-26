import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/entities/database/flashcard_entity.dart';
import '../../../../domain/entities/database/words_entity.dart';
import '../../../../domain/use_case/add_word_use_case.dart' as add_word;
import '../../../../domain/use_case/delete_word_use_case.dart' as delete_word;
import '../../../../domain/use_case/edit_word_use_case.dart' as edit_word;
import '../../../../domain/use_case/get_collections_use_case.dart';
import 'edit_words_state.dart';

@injectable
class EditWordsCubit extends Cubit<EditWordsState> {
  EditWordsCubit(
    this._deleteWordUseCase,
    this._getCollectionsUseCase,
    this._addWordUseCase,
    this._editWordUseCase,
  ) : super(const EditWordsState.initial());

  final delete_word.DeleteWordUseCase _deleteWordUseCase;
  final add_word.AddWordUseCase _addWordUseCase;
  final edit_word.EditWordUseCase _editWordUseCase;
  final GetCollectionsUseCase _getCollectionsUseCase;
  late FlashcardEntity flashcardEntity;

  Future<void> entityInit(FlashcardEntity entity) async {
    flashcardEntity = entity;
  }

  Future<void> reloadPage() async {
    final result = await _getCollectionsUseCase();
    result.fold(
      //TODO:Implement Error
      (l) => null,
      (r) {
        final reloadedEntity = r.firstWhere(
          (element) => element.folderName == flashcardEntity.folderName,
        );
        emit(
          EditWordsState.reload(reloadedEntity),
        );
      },
    );
  }

  Future<void> onBackButton() async {
    final result = await _getCollectionsUseCase();
    result.fold((l) => null, (r) {
      final reloadedEntity = r.firstWhere(
        (element) => element.folderName == flashcardEntity.folderName,
      );
      emit(EditWordsState.onBackButton(reloadedEntity));
    });
  }

  Future<void> deleteWord(FlashcardEntity entity, int index, {bool withoutReload = false}) async {
    emit(const EditWordsState.loading(withPop: false));
    final result = await _deleteWordUseCase(delete_word.Params(index, entity));
    result.fold(
      //TODO: Implement error
      (l) => l,
      (r) => withoutReload ? r : reloadPage(),
    );
  }

  Future<void> updateWord(
    String enWord,
    String translatedWord,
    String folderName, {
    isEditWord = false,
    int index = -1,
    FlashcardEntity? entity,
  }) async {
    if (enWord.isNotEmpty && translatedWord.isNotEmpty) {
      emit(const EditWordsState.loading(withPop: false));
      if (!isEditWord) {
        final result = await _addWordUseCase(
          add_word.Params(
            WordsEntity(
              enWord: enWord,
              translatedWord: translatedWord,
              nrRepeated: 0,
            ),
            folderName,
          ),
        );
        result.fold(
          //TODO: Implement error
          (l) => l,
          (r) => reloadPage(),
        );
      } else {
        await deleteWord(entity!, index, withoutReload: true);
        final result = await _editWordUseCase(
          edit_word.Params(
            WordsEntity(
              enWord: enWord,
              translatedWord: translatedWord,
              nrRepeated: 0,
            ),
            folderName,
          ),
        );
        result.fold(
          //TODO: Implement error
          (l) => l,
          (r) => reloadPage(),
        );
      }
    } else if (enWord.isEmpty && translatedWord.isNotEmpty) {
      emit(const EditWordsState.loading(withPop: true));
      emit(const EditWordsState.updateWordFailure(emptyEnWord: true, emptyTranslatedWord: false));
    } else if (enWord.isNotEmpty && translatedWord.isEmpty) {
      emit(const EditWordsState.loading(withPop: true));
      emit(const EditWordsState.updateWordFailure(emptyEnWord: false, emptyTranslatedWord: true));
    } else {
      emit(const EditWordsState.loading(withPop: true));
      emit(const EditWordsState.updateWordFailure(emptyEnWord: true, emptyTranslatedWord: true));
    }
  }
}
