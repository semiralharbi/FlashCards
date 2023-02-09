import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../entities/database/flashcard_entity.dart';
import '../repositories/database_repository.dart';
import '../utils/failure.dart';
import '../utils/success.dart';
import '../utils/use_case.dart';

@injectable
class UpdateFolderDataUseCase implements UseCase<Success, FlashcardEntity> {
  const UpdateFolderDataUseCase(this._databaseRepository);

  final DatabaseRepository _databaseRepository;

  @override
  Future<Either<Failure, Success>> call(FlashcardEntity entity) async {
    return (await _databaseRepository.updateCollection(entity)).fold(
      (failure) => Left(failure),
      (r) => const Right(Success()),
    );
  }
}