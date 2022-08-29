import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/entities/database/words_entity.dart';

part 'flashcard_state.freezed.dart';

@freezed
class FlashcardState with _$FlashcardState {
  const factory FlashcardState.initial() = _Initial;
  const factory FlashcardState.results() = _Results;

  const factory FlashcardState.next(
    List<WordsEntity> entity,
    int index,
  ) = _Next;
}
