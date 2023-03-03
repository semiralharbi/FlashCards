import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/entities/words/everything_entity.dart';
import '../../../utils/enums/errors.dart';

part 'dictionary_state.freezed.dart';

@freezed
class DictionaryState with _$DictionaryState {
  const factory DictionaryState.initial() = _Initial;

  const factory DictionaryState.loading() = _Load;

  const factory DictionaryState.failure(Errors errors) = _Fail;

  const factory DictionaryState.success(EverythingEntity entity) = _Search;
}
