import 'package:dartz/dartz.dart';

import '../entities/words/everything_entity.dart';
import '../utils/failure.dart';

abstract class WordsRepository {
  Future<Either<Failure, EverythingEntity>> getEverything(String word);
}
