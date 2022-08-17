import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../app/utils/enums/errors.dart';
import '../../domain/data_source/remote/database_remote_source.dart';
import '../../domain/entities/database/flashcard_entity.dart';
import '../../domain/repositories/database_repository.dart';
import '../../domain/utils/exception.dart';
import '../../domain/utils/failure.dart';
import '../../domain/utils/success.dart';
import '../dto/database/flashcard_dto.dart';

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
}
