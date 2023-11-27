import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../entities/database/folder_entity.dart';
import '../repositories/database_repository.dart';
import '../utils/failure.dart';
import '../utils/success.dart';
import '../utils/use_case.dart';

@injectable
class CreateFolderUseCase implements UseCase<Success, FolderEntity> {
  const CreateFolderUseCase(this._databaseRepository);

  final DatabaseRepository _databaseRepository;

  @override
  Future<Either<Failure, Success>> call(FolderEntity entity) async {
    return (await _databaseRepository.newFolder(entity)).fold(
      (failure) => Left(failure),
      (r) => const Right(Success()),
    );
  }
}
