import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/dto/database/folder_dto.dart';
import 'words_entity.dart';

part 'folder_entity.freezed.dart';

@freezed
class FolderEntity with _$FolderEntity {
  const factory FolderEntity({
    required String folderName,
    required List<WordsEntity> words,
    required String sourceLanguage,
    required String targetLanguage,
    int? correctAnswers,
  }) = _FolderEntity;

  factory FolderEntity.fromDto(FolderDto dto) => FolderEntity(
        folderName: dto.folderName,
        words: dto.words.map((dto) => WordsEntity.fromDto(dto)).toList(),
        correctAnswers: dto.correctAnswers,
        sourceLanguage: dto.sourceLanguage,
        targetLanguage: dto.targetLanguage,
      );
}
