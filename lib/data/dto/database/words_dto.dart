import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/database/words_entity.dart';

part 'words_dto.freezed.dart';
part 'words_dto.g.dart';

@freezed
class WordsDto with _$WordsDto {
  const factory WordsDto({
    required String wordToTranslate,
    required String translatedWord,
    bool? correctAnswer,
    required int nrRepeated,
  }) = _WordsDto;

  factory WordsDto.fromJson(Map<String, dynamic> json) => _$WordsDtoFromJson(json);

  factory WordsDto.fromEntity(WordsEntity entity) {
    return WordsDto(
      wordToTranslate: entity.wordToTranslate,
      translatedWord: entity.translatedWord,
      correctAnswer: entity.correctAnswer,
      nrRepeated: entity.nrRepeated,
    );
  }
}
