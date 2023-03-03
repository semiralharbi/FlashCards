import 'package:freezed_annotation/freezed_annotation.dart';

part 'definition_entity.freezed.dart';

@freezed
class DefinitionEntity with _$DefinitionEntity {
  const factory DefinitionEntity({
    String? definition,
    String? partOfSpeech,
    List<String>? synonyms,
    List<String>? typeOf,
    List<String>? examples,
  }) = _DefinitionEntity;
}
