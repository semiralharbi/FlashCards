import 'package:dartz/dartz.dart';

import '../entities/database/flashcard_entity.dart';
import '../utils/failure.dart';
import '../utils/success.dart';

abstract class DatabaseRepository {
  Future<Either<Failure, Success>> newFolder(
    FlashcardEntity entity,
  );
}
