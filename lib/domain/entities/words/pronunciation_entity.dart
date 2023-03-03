import 'package:freezed_annotation/freezed_annotation.dart';

part 'pronunciation_entity.freezed.dart';

@freezed
class PronunciationEntity with _$PronunciationEntity {
  const factory PronunciationEntity({
    required String all,
  }) = _PronunciationEntity;
}
