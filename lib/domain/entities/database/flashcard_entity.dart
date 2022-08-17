import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/dto/database/flashcard_dto.dart';

part 'flashcard_entity.freezed.dart';

part 'flashcard_entity.g.dart';

@freezed
class FlashcardEntity with _$FlashcardEntity {
  const factory FlashcardEntity({
    required String folderName,
    required String enWord,
    required String translatedWord,
    bool? correctAnswer,
    required int nrRepeated,
  }) = _FlashcardEntity;

  factory FlashcardEntity.fromDto(FlashcardDto dto) => FlashcardEntity(
    folderName: dto.folderName,
    enWord: dto.enWord,
    translatedWord: dto.translatedWord,
    correctAnswer: dto.correctAnswer,
    nrRepeated: dto.nrRepeated,
  );

  factory FlashcardEntity.fromJson(Map<String, dynamic> json) =>
      _$FlashcardEntityFromJson(json);
}
