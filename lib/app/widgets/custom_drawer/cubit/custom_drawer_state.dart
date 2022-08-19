import 'package:freezed_annotation/freezed_annotation.dart';


part 'custom_drawer_state.freezed.dart';

@freezed
class CustomDrawerState with _$CustomDrawerState {
  const factory CustomDrawerState.initial() = _DrawerInitial;

  const factory CustomDrawerState.logout() = _Logout;

}
