import 'package:freezed_annotation/freezed_annotation.dart';

part 'registration_page_state.freezed.dart';

@freezed
class RegistrationPageState with _$RegistrationPageState {
  const factory RegistrationPageState.initial() = _Initial;

  const factory RegistrationPageState.fail() = _Fail;

  const factory RegistrationPageState.userRegistration({
    String? username,
    String? email,
  }) = _UserRegistration;

  const factory RegistrationPageState.registerSuccess() = _RegisterSuccess;
}