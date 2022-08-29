import 'package:dartz/dartz.dart';

import '../entities/database/flashcard_entity.dart';
import '../utils/failure.dart';
import '../utils/success.dart';

abstract class DatabaseRepository {
  Future<Either<Failure, Success>> newFolder(FlashcardEntity entity);

  Future<Either<Failure, List<FlashcardEntity>>> getCollections();

  Future<Either<Failure, Success>> updateCollection(FlashcardEntity entity);
}
