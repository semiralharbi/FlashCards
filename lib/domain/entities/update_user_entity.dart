import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/dto/update_user_dto.dart';


part 'update_user_entity.freezed.dart';

part 'update_user_entity.g.dart';

@freezed
class UpdateUserEntity with _$UpdateUserEntity {
  const factory UpdateUserEntity({
    required String username,
  }) = _UpdateUserEntity;

  factory UpdateUserEntity.fromDto(UpdateUserDto dto) => UpdateUserEntity(
    username: dto.username,
  );

  factory UpdateUserEntity.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserEntityFromJson(json);
}
