import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../utils/enums/errors.dart';

part 'username_state.freezed.dart';

@freezed
class UsernameState with _$UsernameState {
  const factory UsernameState.loaded({
    String? username,
    Errors? usernameError,
  }) = _Loaded;

  const factory UsernameState.loading() = _Loading;

  const factory UsernameState.fail({required Errors error}) = _Fail;

  const factory UsernameState.success() = _Success;
}
