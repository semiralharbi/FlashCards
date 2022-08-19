import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/database/flashcard_entity.dart';
import 'words_dto.dart';

part 'flashcard_dto.freezed.dart';

part 'flashcard_dto.g.dart';

@freezed
class FlashcardDto with _$FlashcardDto {
  const factory FlashcardDto({
    required String folderName,
    required List<WordsDto> words,
    int? correctAnswers,
  }) = _FlashcardDto;

  factory FlashcardDto.fromJson(Map<String, dynamic> json) => _$FlashcardDtoFromJson(json);

  factory FlashcardDto.fromEntity(FlashcardEntity entity) {
    return FlashcardDto(
      folderName: entity.folderName,
      words: entity.words.map((entity) => WordsDto.fromEntity(entity)).toList(),
      correctAnswers: entity.correctAnswers,
    );
  }
}
