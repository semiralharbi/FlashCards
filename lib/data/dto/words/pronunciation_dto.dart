import 'package:freezed_annotation/freezed_annotation.dart';

part 'pronunciation_dto.freezed.dart';

part 'pronunciation_dto.g.dart';

@freezed
class PronunciationDto with _$PronunciationDto {
  const factory PronunciationDto({
    required String all,
  }) = _PronunciationDto;

  factory PronunciationDto.fromJson(Map<String, dynamic> json) => _$PronunciationDtoFromJson(json);
}
