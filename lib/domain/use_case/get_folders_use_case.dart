import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../entities/database/folder_entity.dart';
import '../repositories/folders_repository.dart';
import '../utils/failure.dart';
import '../utils/use_case.dart';

@injectable
class GetFoldersUseCase implements NoParamsUseCaseWithFailure<List<FolderEntity>> {
  const GetFoldersUseCase(this._databaseRepository);

  final FoldersRepository _databaseRepository;

  @override
  Future<Either<Failure, List<FolderEntity>>> call() async {
    return (await _databaseRepository.getFolders()).fold(
      (failure) => Left(failure),
      (r) => Right(r),
    );
  }
}
