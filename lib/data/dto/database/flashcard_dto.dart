import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/database/flashcard_entity.dart';

part 'flashcard_dto.freezed.dart';

part 'flashcard_dto.g.dart';

@freezed
class FlashcardDto with _$FlashcardDto {
  const factory FlashcardDto({
    required String folderName,
    required String enWord,
    required String translatedWord,
    bool? correctAnswer,
    required int nrRepeated,
  }) = _FlashcardDto;

  factory FlashcardDto.fromJson(Map<String, dynamic> json) => _$FlashcardDtoFromJson(json);

  factory FlashcardDto.fromEntity(FlashcardEntity entity) {
    return FlashcardDto(
      folderName: entity.folderName,
      enWord: entity.enWord,
      translatedWord: entity.translatedWord,
      correctAnswer: entity.correctAnswer,
      nrRepeated: entity.nrRepeated,
    );
  }
}
