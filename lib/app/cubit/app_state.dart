import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_state.freezed.dart';

@freezed
class AppState with _$AppState {
  const factory AppState.initial() = _Initial;

  const factory AppState.toLogin() = _Login;

  const factory AppState.toUsernamePage() = _UsernamePage;

  const factory AppState.toHomePage() = _HomePage;
}
