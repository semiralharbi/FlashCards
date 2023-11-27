import '../../../data/dto/database/folder_dto.dart';
import '../../../data/dto/database/words_dto.dart';
import '../../utils/success.dart';

abstract class DatabaseRemoteSource {
  Future<Success> newFolder(FolderDto dto);

  Future<List<FolderDto>> getCollection();

  Future<Success> updateCollection(FolderDto dto);

  Future<Success> deleteCollection(FolderDto dto);

  Future<Success> deleteWord(FolderDto dto, int index);

  Future<Success> addWord(WordsDto dto, String folderName);

  Future<Success> editWord(WordsDto dto, String folderName);
}
