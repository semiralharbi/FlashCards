import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/dto/user/user_profile_dto.dart';

part 'user_profile_entity.freezed.dart';

@freezed
class UserProfileEntity with _$UserProfileEntity {
  const factory UserProfileEntity({
    String? name,
    String? userId,
    String? initialLanguage,
    String? email,
    String? appLanguage,
    String? nativeLanguage,
    String? languageToLearn,
  }) = _UserProfileEntity;

  factory UserProfileEntity.fromDto(UserProfileDto dto) {
    return UserProfileEntity(
      name: dto.name,
      userId: dto.userId,
      initialLanguage: dto.initialLanguage,
      email: dto.email,
      appLanguage: dto.appLanguage,
      nativeLanguage: dto.nativeLanguage,
      languageToLearn: dto.languageToLearn,
    );
  }
}
