import '../../entities/database/words_entity.dart';

abstract class DatabaseLocalSource {
  Future<void> saveCardsAnswers(List<WordsEntity> entity);

  Future<List<WordsEntity>> getCardsAnswers();

  Future<void> clearCardsAnswers();
}
