import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/dto/words/everything_dto.dart';
import 'definition_entity.dart';
import 'pronunciation_entity.dart';
import 'syllables_entity.dart';

part 'everything_entity.freezed.dart';

@freezed
class EverythingEntity with _$EverythingEntity {
  const factory EverythingEntity({
    required String word,
    required List<DefinitionEntity>? results,
    required SyllablesEntity? syllables,
    required PronunciationEntity pronunciation,
  }) = _EverythingEntity;

  factory EverythingEntity.fromDto(EverythingDto dto) => EverythingEntity(
        word: dto.word,
        results: dto.results
            ?.map(
              (e) => DefinitionEntity(
                definition: e.definition,
                partOfSpeech: e.partOfSpeech,
                synonyms: e.synonyms,
                typeOf: e.typeOf,
                examples: e.examples,
              ),
            )
            .toList(),
        syllables: SyllablesEntity(
          count: dto.syllables?.count,
          list: dto.syllables?.list,
        ),
        pronunciation: PronunciationEntity(
          all: dto.pronunciation.all,
        ),
      );
}
