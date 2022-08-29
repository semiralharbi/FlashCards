import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/entities/database/flashcard_entity.dart';

part 'folder_content_state.freezed.dart';

@freezed
class FolderContentState with _$FolderContentState {
  const factory FolderContentState.initial() = _Initial;

  const factory FolderContentState.nextPage(
    FlashcardEntity entity,
    int index,
  ) = _NextPage;
}
