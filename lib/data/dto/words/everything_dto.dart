import 'package:freezed_annotation/freezed_annotation.dart';

import 'definition_dto.dart';
import 'pronunciation_dto.dart';
import 'syllables_dto.dart';

part 'everything_dto.freezed.dart';

part 'everything_dto.g.dart';

@freezed
class EverythingDto with _$EverythingDto {
  const factory EverythingDto({
    required String word,
    required List<DefinitionDto>? results,
    required SyllablesDto? syllables,
    required PronunciationDto pronunciation,
  }) = _EverythingDto;

  factory EverythingDto.fromJson(Map<String, dynamic> json) => _$EverythingDtoFromJson(json);
}
