import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/database/folder_entity.dart';
import 'words_dto.dart';

part 'folder_dto.freezed.dart';

part 'folder_dto.g.dart';

@freezed
class FolderDto with _$FolderDto {
  const factory FolderDto({
    required String folderName,
    required List<WordsDto> words,
    int? correctAnswers,
  }) = _FolderDto;

  factory FolderDto.fromJson(Map<String, dynamic> json) => _$FolderDtoFromJson(json);

  factory FolderDto.fromEntity(FolderEntity entity) {
    return FolderDto(
      folderName: entity.folderName,
      words: entity.words.map((entity) => WordsDto.fromEntity(entity)).toList(),
      correctAnswers: entity.correctAnswers,
    );
  }
}
