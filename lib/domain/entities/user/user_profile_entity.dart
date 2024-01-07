import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/dto/database/folder_dto.dart';
import '../../../data/dto/user/user_profile_dto.dart';

part 'user_profile_entity.freezed.dart';

@freezed
class UserProfileEntity with _$UserProfileEntity {
  const factory UserProfileEntity({
    required String name,
    required String userId,
    required String initialLanguage,
    required String email,
    required List<FolderDto> userFolders,
  }) = _UserProfileEntity;

  factory UserProfileEntity.fromDto(UserProfileDto dto) {
    return UserProfileEntity(
      name: dto.name,
      userId: dto.userId,
      initialLanguage: dto.initialLanguage,
      userFolders: dto.userFolders,
      email: dto.email,
    );
  }
}
