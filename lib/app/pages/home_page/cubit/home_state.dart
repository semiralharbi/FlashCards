import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/entities/database/folder_entity.dart';
import '../../../utils/enums/errors.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.loaded({required List<FolderEntity> folders}) = _Loaded;

  const factory HomeState.fail(Errors error) = _Fail;

  const factory HomeState.empty({Errors? failure}) = _Empty;

  const factory HomeState.loading() = _Loading;

  const factory HomeState.logout() = _Logout;
}
