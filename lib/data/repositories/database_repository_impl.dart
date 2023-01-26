import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../app/utils/enums/errors.dart';
import '../../domain/data_source/remote/database_remote_source.dart';
import '../../domain/entities/database/flashcard_entity.dart';
import '../../domain/entities/database/words_entity.dart';
import '../../domain/repositories/database_repository.dart';
import '../../domain/utils/exception.dart';
import '../../domain/utils/failure.dart';
import '../../domain/utils/success.dart';
import '../dto/database/flashcard_dto.dart';
import '../dto/database/words_dto.dart';

@Injectable(as: DatabaseRepository)
class DatabaseRepositoryImpl implements DatabaseRepository {
  DatabaseRepositoryImpl(this._remoteSource);

  final DatabaseRemoteSource _remoteSource;

  @override
  Future<Either<Failure, Success>> newFolder(FlashcardEntity entity) async {
    try {
      await _remoteSource.newFolder(FlashcardDto.fromEntity(entity));
      return const Right(Success());
    } on ApiException catch (e) {
      return Left(Failure(appError: e.failure));
    } catch (e) {
      return const Left(Failure(appError: Errors.unknownError));
    }
  }

  @override
  Future<Either<Failure, List<FlashcardEntity>>> getCollections() async {
    try {
      final dto = await _remoteSource.getCollection();
      return Right(
        dto.map((dto) => FlashcardEntity.fromDto(dto)).toList(),
      );
    } on ApiException catch (e) {
      return Left(Failure(appError: e.failure));
    } catch (e) {
      return const Left(Failure(appError: Errors.unknownError));
    }
  }

  @override
  Future<Either<Failure, Success>> updateCollection(FlashcardEntity entity) async {
    try {
      await _remoteSource.updateCollection(FlashcardDto.fromEntity(entity));
      return const Right(Success());
    } on ApiException catch (e) {
      return Left(Failure(appError: e.failure));
    } catch (e) {
      return const Left(Failure(appError: Errors.unknownError));
    }
  }

  @override
  Future<Either<Failure, Success>> deleteCollection(FlashcardEntity entity) async {
    try {
      await _remoteSource.deleteCollection(FlashcardDto.fromEntity(entity));
      return const Right(Success());
    } on ApiException catch (e) {
      return Left(Failure(appError: e.failure));
    } catch (e) {
      return const Left(Failure(appError: Errors.unknownError));
    }
  }

  @override
  Future<Either<Failure, Success>> deleteWord(FlashcardEntity entity, int index) async {
    try {
      await _remoteSource.deleteWord(FlashcardDto.fromEntity(entity), index);
      return const Right(Success());
    } on ApiException catch (e) {
      return Left(Failure(appError: e.failure));
    } catch (e) {
      return const Left(Failure(appError: Errors.unknownError));
    }
  }

  @override
  Future<Either<Failure, Success>> addWord(WordsEntity entity, String folderName) async {
    try {
      await _remoteSource.addWord(WordsDto.fromEntity(entity), folderName);
      return const Right(Success());
    } on ApiException catch (e) {
      return Left(Failure(appError: e.failure));
    } catch (e) {
      return const Left(Failure(appError: Errors.unknownError));
    }
  }

  @override
  Future<Either<Failure, Success>> editWord(WordsEntity entity, String folderName) async {
    try {
      await _remoteSource.editWord(WordsDto.fromEntity(entity), folderName);
      return const Right(Success());
    } on ApiException catch (e) {
      return Left(Failure(appError: e.failure));
    } catch (e) {
      return const Left(Failure(appError: Errors.unknownError));
    }
  }
}
