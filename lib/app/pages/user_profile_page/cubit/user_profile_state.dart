import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../utils/enums/errors.dart';

part 'user_profile_state.freezed.dart';

@freezed
class UserProfileState with _$UserProfileState {
  const factory UserProfileState.loaded({
    String? username,
    Errors? usernameError,
  }) = _Loaded;

  const factory UserProfileState.loading() = _Loading;

  const factory UserProfileState.fail({required Errors error}) = _Fail;

  const factory UserProfileState.success() = _Success;
}
