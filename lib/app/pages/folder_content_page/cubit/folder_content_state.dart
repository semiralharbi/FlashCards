import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/entities/database/words_entity.dart';

part 'folder_content_state.freezed.dart';

@freezed
class FolderContentState with _$FolderContentState {
  const factory FolderContentState.initial() = _Initial;

  const factory FolderContentState.nextPage(
    List<WordsEntity> entity,
    int index,
  ) = _NextPage;
}
