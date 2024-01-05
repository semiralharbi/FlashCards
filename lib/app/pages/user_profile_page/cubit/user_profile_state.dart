import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/entities/user/user_profile_entity.dart';
import '../../../utils/enums/errors.dart';

part 'user_profile_state.freezed.dart';

@freezed
class UserProfileState with _$UserProfileState {
  factory UserProfileState.loaded({
    UserProfileEntity? userProfile,
    Errors? usernameError,
  }) = _Loaded;

  const factory UserProfileState.loading() = _Loading;

  const factory UserProfileState.fail({required Errors error}) = _Fail;

  const factory UserProfileState.success() = _Success;
}
