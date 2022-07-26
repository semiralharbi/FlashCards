import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../utils/enums/errors.dart';

part 'home_page_state.freezed.dart';

@freezed
class HomePageState with _$HomePageState {
  const factory HomePageState.initial({
    String? email,
    String? password,
  }) = _Initial;

  const factory HomePageState.loading() = _Loading;

  const factory HomePageState.fail({Errors? error}) = _Fail;

  const factory HomePageState.loginSuccess() = _LoginSuccess;
}
