import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../utils/enums/errors.dart';

part 'login_page_state.freezed.dart';

@freezed
class LoginPageState with _$LoginPageState {
  const factory LoginPageState.initial({
    String? email,
    String? password,
  }) = _Initial;

  const factory LoginPageState.loading() = _Loading;

  const factory LoginPageState.fail({Errors? error}) = _Fail;

  const factory LoginPageState.loginSuccess() = _LoginSuccess;
}
