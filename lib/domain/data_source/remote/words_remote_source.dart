import '../../../data/dto/words/everything_dto.dart';

abstract class WordsRemoteSource {
  Future<EverythingDto> getEverything(String word);
}
