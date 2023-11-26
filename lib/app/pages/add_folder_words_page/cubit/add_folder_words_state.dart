part of 'add_folder_words_cubit.dart';

@freezed
class AddFolderWordsState with _$AddFolderWordsState {
  const factory AddFolderWordsState.loading() = _Loading;

  const factory AddFolderWordsState.loaded(List<WordsEntity> wordsList) = _Loaded;

  const factory AddFolderWordsState.failure(Errors error) = _Fail;

  const factory AddFolderWordsState.success() = _Success;
}
