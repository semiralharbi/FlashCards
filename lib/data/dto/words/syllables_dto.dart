import 'package:freezed_annotation/freezed_annotation.dart';

part 'syllables_dto.freezed.dart';

part 'syllables_dto.g.dart';

@freezed
class SyllablesDto with _$SyllablesDto {
  const factory SyllablesDto({
    int? count,
    List<String>? list,
  }) = _SyllablesDto;

  factory SyllablesDto.fromJson(Map<String, dynamic> json) => _$SyllablesDtoFromJson(json);
}
