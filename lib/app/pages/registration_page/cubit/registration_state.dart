import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../utils/enums/errors.dart';

part 'registration_state.freezed.dart';

@freezed
class RegistrationState with _$RegistrationState {
  const factory RegistrationState.loading() = _Loading;

  const factory RegistrationState.fail({required Errors error}) = _Fail;

  const factory RegistrationState.loaded({
    String? email,
    String? password,
    String? repeatPassword,
    Errors? emailError,
    Errors? passwordError,
    Errors? repeatPasswordError,
  }) = _UserRegistration;

  const factory RegistrationState.success() = _Success;
}
