import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/update_user_entity.dart';

part 'update_user_dto.freezed.dart';

part 'update_user_dto.g.dart';

@freezed
class UpdateUserDto with _$UpdateUserDto {
  const factory UpdateUserDto({
    required String username,
  }) = _UpdateUserDto;

  factory UpdateUserDto.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserDtoFromJson(json);

  factory UpdateUserDto.fromEntity(UpdateUserEntity entity) {
    return UpdateUserDto(
      username: entity.username,
    );
  }
}
