import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/dto/login_dto.dart';

part 'login_entity.freezed.dart';

part 'login_entity.g.dart';

@freezed
class LoginEntity with _$LoginEntity {
  const factory LoginEntity({
    required String email,
    required String password,
  }) = _LoginEntity;

  factory LoginEntity.fromDto(LoginDto dto) => LoginEntity(
    email: dto.email,
    password: dto.password,
  );

  factory LoginEntity.fromJson(Map<String, dynamic> json) =>
      _$LoginEntityFromJson(json);
}
