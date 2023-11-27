import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../entities/database/folder_entity.dart';
import '../repositories/database_repository.dart';
import '../utils/failure.dart';
import '../utils/success.dart';
import '../utils/use_case.dart';

@injectable
class DeleteFolderDataUseCase implements UseCase<Success, FolderEntity> {
  const DeleteFolderDataUseCase(this._databaseRepository);

  final DatabaseRepository _databaseRepository;

  @override
  Future<Either<Failure, Success>> call(FolderEntity entity) async {
    return (await _databaseRepository.deleteCollection(entity)).fold(
      (failure) => Left(failure),
      (r) => const Right(Success()),
    );
  }
}
