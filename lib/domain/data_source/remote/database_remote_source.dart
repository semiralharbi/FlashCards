import '../../../data/dto/database/flashcard_dto.dart';
import '../../utils/success.dart';

abstract class DatabaseRemoteSource {
  Future<Success> newFolder(FlashcardDto dto);
  Future<List<FlashcardDto>> getCollection();
}
