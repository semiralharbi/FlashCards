import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/entities/database/flashcard_entity.dart';
import '../../../../domain/utils/failure.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.initial({
    List<FlashcardEntity>? entity,
    Failure? failure,
  }) = _HomeInitial;

  const factory HomeState.fail() = _Fail;
}
