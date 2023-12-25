import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/entities/database/folder_entity.dart';

part 'folder_content_state.freezed.dart';

@freezed
class FolderContentState with _$FolderContentState {
  const factory FolderContentState.initial() = _Initial;

  const factory FolderContentState.loaded(FolderEntity entity) = _Loaded;

  const factory FolderContentState.nextPage(
    FolderEntity entity,
    int index,
  ) = _NextPage;
}
