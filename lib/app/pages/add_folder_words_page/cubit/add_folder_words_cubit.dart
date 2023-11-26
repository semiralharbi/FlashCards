import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/entities/database/flashcard_entity.dart';
import '../../../../domain/entities/database/words_entity.dart';
import '../../../../domain/use_case/new_data_folder_use_case.dart';
import '../../../theme/global_imports.dart';
import '../../../utils/enums/errors.dart';

part 'add_folder_words_state.dart';

part 'add_folder_words_cubit.freezed.dart';

@injectable
class AddFolderWordsCubit extends Cubit<AddFolderWordsState> {
  AddFolderWordsCubit(this._createFolderUseCase) : super(const AddFolderWordsState.loaded([]));

  final CreateFolderUseCase _createFolderUseCase;
  final List<WordsEntity> wordsList = [];

  Future<void> createFolder({
    required String folderName,
  }) async {
    emit(const AddFolderWordsState.loading());
    final result = await _createFolderUseCase(
      FlashcardEntity(
        folderName: folderName,
        correctAnswers: 0,
        words: wordsList,
      ),
    );
    result.fold(
      (l) => emit(AddFolderWordsState.failure(l.appError ?? Errors.unknownError)),
      (r) => emit(const AddFolderWordsState.success()),
    );
  }

  void addWord(WordsEntity wordsEntity) {
    emit(const AddFolderWordsState.loading());
    wordsList.add(wordsEntity);
    emit(AddFolderWordsState.loaded(wordsList));
  }
}
