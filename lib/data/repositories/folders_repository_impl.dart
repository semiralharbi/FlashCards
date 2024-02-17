import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../app/utils/enums/errors.dart';
import '../../domain/data_source/remote/database_remote_source.dart';
import '../../domain/entities/database/folder_entity.dart';
import '../../domain/entities/database/words_entity.dart';
import '../../domain/repositories/folders_repository.dart';
import '../../domain/utils/exception.dart';
import '../../domain/utils/failure.dart';
import '../../domain/utils/success.dart';
import '../dto/database/folder_dto.dart';
import '../dto/database/words_dto.dart';

@Injectable(as: FoldersRepository)
class FoldersRepositoryImpl implements FoldersRepository {
  FoldersRepositoryImpl(this._remoteSource);

  final FoldersDataSource _remoteSource;

  @override
  Future<Either<Failure, Success>> newFolder(FolderEntity entity) async {
    try {
      await _remoteSource.createCollection(FolderDto.fromEntity(entity));
      return const Right(Success());
    } on ApiException catch (e) {
      return Left(Failure(error: e.failure));
    } catch (e) {
      return const Left(Failure(error: Errors.unknownError));
    }
  }

  @override
  Future<Either<Failure, List<FolderEntity>>> getFolders() async {
    try {
      final dto = await _remoteSource.getCollection();
      return Right(dto.map((dto) => FolderEntity.fromDto(dto)).toList());
    } on ApiException catch (e) {
      return Left(Failure(error: e.failure));
    } catch (e) {
      return const Left(Failure(error: Errors.unknownError));
    }
  }

  @override
  Future<Either<Failure, Success>> updateCollection(FolderEntity entity) async {
    try {
      await _remoteSource.updateCollection(FolderDto.fromEntity(entity));
      return const Right(Success());
    } on ApiException catch (e) {
      return Left(Failure(error: e.failure));
    } catch (e) {
      return const Left(Failure(error: Errors.unknownError));
    }
  }

  @override
  Future<Either<Failure, Success>> deleteCollection(FolderEntity entity) async {
    try {
      await _remoteSource.deleteCollection(FolderDto.fromEntity(entity));
      return const Right(Success());
    } on ApiException catch (e) {
      return Left(Failure(error: e.failure));
    } catch (e) {
      return const Left(Failure(error: Errors.unknownError));
    }
  }

  @override
  Future<Either<Failure, Success>> deleteWord(FolderEntity entity, int index) async {
    try {
      await _remoteSource.deleteWord(FolderDto.fromEntity(entity), index);
      return const Right(Success());
    } on ApiException catch (e) {
      return Left(Failure(error: e.failure));
    } catch (e) {
      return const Left(Failure(error: Errors.unknownError));
    }
  }

  @override
  Future<Either<Failure, Success>> addWord(WordsEntity entity, String folderName) async {
    try {
      await _remoteSource.addWord(WordsDto.fromEntity(entity), folderName);
      return const Right(Success());
    } on ApiException catch (e) {
      return Left(Failure(error: e.failure));
    } catch (e) {
      return const Left(Failure(error: Errors.unknownError));
    }
  }

  @override
  Future<Either<Failure, Success>> editWord(WordsEntity entity, String folderName) async {
    try {
      await _remoteSource.editWord(WordsDto.fromEntity(entity), folderName);
      return const Right(Success());
    } on ApiException catch (e) {
      return Left(Failure(error: e.failure));
    } catch (e) {
      return const Left(Failure(error: Errors.unknownError));
    }
  }
}
