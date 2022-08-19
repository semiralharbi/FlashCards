import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../utils/enums/errors.dart';

part 'registration_page_state.freezed.dart';

@freezed
class RegistrationPageState with _$RegistrationPageState {
  const factory RegistrationPageState.initial() = _Initial;

  const factory RegistrationPageState.fail({
    Errors? error,
  }) = _Fail;

  const factory RegistrationPageState.content({
    String? email,
    String? password,
    String? repeatPassword,
    Errors? emailError,
    Errors? passwordError,
    Errors? repeatPasswordError,
  }) = _UserRegistration;

  const factory RegistrationPageState.registerSuccess() = _RegisterSuccess;
}
