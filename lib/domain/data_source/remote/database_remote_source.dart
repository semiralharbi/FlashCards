import '../../../data/dto/database/flashcard_dto.dart';
import '../../../data/dto/database/words_dto.dart';
import '../../utils/success.dart';

abstract class DatabaseRemoteSource {
  Future<Success> newFolder(FlashcardDto dto);

  Future<List<FlashcardDto>> getCollection();

  Future<Success> updateCollection(FlashcardDto dto);

  Future<Success> deleteCollection(FlashcardDto dto);

  Future<Success> deleteWord(FlashcardDto dto, int index);

  Future<Success> addWord(WordsDto dto, String folderName);

  Future<Success> editWord(WordsDto dto, String folderName);
}
