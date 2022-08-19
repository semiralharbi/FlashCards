import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../utils/enums/errors.dart';

part 'username_page_state.freezed.dart';

@freezed
class UsernamePageState with _$UsernamePageState {
  const factory UsernamePageState.initial({String? username}) = _Initial;

  const factory UsernamePageState.loading() = _Loading;

  const factory UsernamePageState.fail({
    Errors? error,
  }) = _Fail;

  const factory UsernamePageState.success() = _Success;
}
