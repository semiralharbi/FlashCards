import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/dto/database/flashcard_dto.dart';
import 'words_entity.dart';

part 'flashcard_entity.freezed.dart';

@freezed
class FlashcardEntity with _$FlashcardEntity {
  const factory FlashcardEntity({
    required String folderName,
    required List<WordsEntity> words,
    int? correctAnswers,
  }) = _FlashcardEntity;

  factory FlashcardEntity.fromDto(FlashcardDto dto) => FlashcardEntity(
        folderName: dto.folderName,
        words: dto.words.map((dto) => WordsEntity.fromDto(dto)).toList(),
        correctAnswers: dto.correctAnswers,
      );
}
