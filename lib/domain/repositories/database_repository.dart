import 'package:dartz/dartz.dart';

import '../entities/database/flashcard_entity.dart';
import '../entities/database/words_entity.dart';
import '../utils/failure.dart';
import '../utils/success.dart';

abstract class DatabaseRepository {
  Future<Either<Failure, Success>> newFolder(FlashcardEntity entity);

  Future<Either<Failure, List<FlashcardEntity>>> getCollections();

  Future<Either<Failure, Success>> updateCollection(FlashcardEntity entity);

  Future<Either<Failure, Success>> deleteCollection(FlashcardEntity entity);

  Future<Either<Failure, Success>> deleteWord(FlashcardEntity entity, int index);

  Future<Either<Failure, Success>> addWord(WordsEntity entity, String folderName);

  Future<Either<Failure, Success>> editWord(WordsEntity entity, String folderName);
}
