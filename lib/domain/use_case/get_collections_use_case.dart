import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../entities/database/flashcard_entity.dart';
import '../repositories/database_repository.dart';
import '../utils/failure.dart';
import '../utils/use_case.dart';

@injectable
class GetCollectionsUseCase implements NoParamsUseCaseWithFailure<List<FlashcardEntity>> {
  const GetCollectionsUseCase(this._databaseRepository);

  final DatabaseRepository _databaseRepository;

  @override
  Future<Either<Failure, List<FlashcardEntity>>> call() async {
    return (await _databaseRepository.getCollections()).fold(
      (failure) => Left(failure),
      (r) => Right(r),
    );
  }
}
