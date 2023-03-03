import 'package:freezed_annotation/freezed_annotation.dart';

part 'syllables_entity.freezed.dart';

@freezed
class SyllablesEntity with _$SyllablesEntity {
  const factory SyllablesEntity({
    int? count,
    List<String>? list,
  }) = _SyllablesEntity;
}
