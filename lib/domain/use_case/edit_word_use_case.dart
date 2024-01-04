import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../entities/database/words_entity.dart';
import '../repositories/folders_repository.dart';
import '../utils/failure.dart';
import '../utils/success.dart';
import '../utils/use_case.dart';

@injectable
class EditWordUseCase implements UseCase<Success, Params> {
  const EditWordUseCase(this._databaseRepository);

  final FoldersRepository _databaseRepository;

  @override
  Future<Either<Failure, Success>> call(Params params) async {
    return (await _databaseRepository.editWord(params.entity, params.folderName)).fold(
      (failure) => Left(failure),
      (r) => const Right(Success()),
    );
  }
}

@immutable
class Params {
  const Params(this.entity, this.folderName);

  final WordsEntity entity;
  final String folderName;
}
