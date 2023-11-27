import 'package:dartz/dartz.dart';

import '../entities/database/folder_entity.dart';
import '../entities/database/words_entity.dart';
import '../utils/failure.dart';
import '../utils/success.dart';

abstract class DatabaseRepository {
  Future<Either<Failure, Success>> newFolder(FolderEntity entity);

  Future<Either<Failure, List<FolderEntity>>> getFolders();

  Future<Either<Failure, Success>> updateCollection(FolderEntity entity);

  Future<Either<Failure, Success>> deleteCollection(FolderEntity entity);

  Future<Either<Failure, Success>> deleteWord(FolderEntity entity, int index);

  Future<Either<Failure, Success>> addWord(WordsEntity entity, String folderName);

  Future<Either<Failure, Success>> editWord(WordsEntity entity, String folderName);
}
