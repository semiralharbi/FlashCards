import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/user/user_profile_entity.dart';
import '../database/folder_dto.dart';

part 'user_profile_dto.freezed.dart';

part 'user_profile_dto.g.dart';

@freezed
class UserProfileDto with _$UserProfileDto {
  const factory UserProfileDto({
    required String name,
    required String userId,
    required String initialLanguage,
    required List<FolderDto> userFolders,
  }) = _UserProfileDto;

  factory UserProfileDto.fromJson(Map<String, dynamic> json) => _$UserProfileDtoFromJson(json);

  factory UserProfileDto.fromEntity(UserProfileEntity entity) {
    return UserProfileDto(
      name: entity.name,
      userId: entity.userId,
      initialLanguage: entity.initialLanguage,
      userFolders: entity.userFolders,
    );
  }
}
