import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/entities/database/folder_entity.dart';
import '../../../utils/enums/errors.dart';

part 'edit_words_state.freezed.dart';

@freezed
class EditWordsState with _$EditWordsState {
  const factory EditWordsState.initial() = _Initial;

  const factory EditWordsState.onBackButton(FolderEntity entity) = _OnBackButton;

  const factory EditWordsState.updateWordFailure({
    required bool emptyEnWord,
    required bool emptyTranslatedWord,
  }) = _UpdateWordFailure;

  const factory EditWordsState.deleteWord() = _DeleteWord;

  const factory EditWordsState.reload(FolderEntity entity) = _Reload;

  const factory EditWordsState.loading({required bool withPop}) = _Loading;

  const factory EditWordsState.fail(Errors? error) = _Fail;
}
