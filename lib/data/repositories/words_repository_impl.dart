import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../app/utils/enums/errors.dart';
import '../../domain/data_source/remote/words_remote_source.dart';
import '../../domain/entities/words/everything_entity.dart';
import '../../domain/repositories/words_repository.dart';
import '../../domain/utils/exception.dart';
import '../../domain/utils/failure.dart';

@Injectable(as: WordsRepository)
class WordsRepositoryImpl implements WordsRepository {
  WordsRepositoryImpl(this._wordsRemoteSource);

  final WordsRemoteSource _wordsRemoteSource;

  @override
  Future<Either<Failure, EverythingEntity>> getEverything(String word) async {
    try {
      final dto = await _wordsRemoteSource.getEverything(word);
      return Right(EverythingEntity.fromDto(dto));
    } on ApiException catch (e) {
      return Left(
        Failure(appError: e.failure),
      );
    } catch (e) {
      return const Left(
        Failure(appError: Errors.unknownError),
      );
    }
  }
}
