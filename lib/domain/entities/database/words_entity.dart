import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/dto/database/words_dto.dart';

part 'words_entity.freezed.dart';

part 'words_entity.g.dart';

@freezed
class WordsEntity with _$WordsEntity {
  const factory WordsEntity({
    required String enWord,
    required String translatedWord,
    bool? correctAnswer,
    required int nrRepeated,
  }) = _WordsEntity;

  factory WordsEntity.fromJson(Map<String, dynamic> json) => _$WordsEntityFromJson(json);

  factory WordsEntity.fromDto(WordsDto dto) {
    return WordsEntity(
      enWord: dto.enWord,
      translatedWord: dto.translatedWord,
      correctAnswer: dto.correctAnswer,
      nrRepeated: dto.nrRepeated,
    );
  }
}
