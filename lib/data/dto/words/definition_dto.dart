import 'package:freezed_annotation/freezed_annotation.dart';

part 'definition_dto.freezed.dart';

part 'definition_dto.g.dart';

@freezed
class DefinitionDto with _$DefinitionDto {
  const factory DefinitionDto({
    String? definition,
    String? partOfSpeech,
    List<String>? synonyms,
    List<String>? derivation,
    List<String>? examples,
  }) = _DefinitionDto;

  factory DefinitionDto.fromJson(Map<String, dynamic> json) => _$DefinitionDtoFromJson(json);
}
