import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../utils/enums/errors.dart';

part 'login_state.freezed.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState.loaded({
    String? email,
    String? password,
  }) = _Loaded;

  const factory LoginState.loading() = _Loading;

  const factory LoginState.fail({required Errors error}) = _Fail;

  const factory LoginState.showHomePage() = _ShowHomePage;

  const factory LoginState.showUsernamePage() = _ShowUsernamePage;
}
