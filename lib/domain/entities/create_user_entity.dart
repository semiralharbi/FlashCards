import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/dto/user/create_user_dto.dart';

part 'create_user_entity.freezed.dart';
part 'create_user_entity.g.dart';

@freezed
class CreateUserEntity with _$CreateUserEntity {
  const factory CreateUserEntity({
    required String email,
    required String password,
  }) = _CreateUserEntity;

  factory CreateUserEntity.fromDto(CreateUserDto dto) => CreateUserEntity(
        email: dto.email,
        password: dto.password,
      );

  factory CreateUserEntity.fromJson(Map<String, dynamic> json) =>
      _$CreateUserEntityFromJson(json);
}
