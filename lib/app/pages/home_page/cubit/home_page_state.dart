import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_page_state.freezed.dart';

@freezed
class HomePageState with _$HomePageState {
  const factory HomePageState.initial() = _Initial;

  const factory HomePageState.fail() = _Fail;

  const factory HomePageState.register() = _Register;

  const factory HomePageState.passwordRegistration({
    String? username,
    String? email,
  }) = _PasswordRegistration;

  const factory HomePageState.loginSuccess() = _LoginSuccess;
}
