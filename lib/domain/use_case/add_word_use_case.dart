import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../entities/database/words_entity.dart';
import '../repositories/folders_repository.dart';
import '../utils/failure.dart';
import '../utils/success.dart';
import '../utils/use_case.dart';

@injectable
class AddWordUseCase implements UseCase<Success, Params> {
  const AddWordUseCase(this._databaseRepository);

  final FoldersRepository _databaseRepository;

  @override
  Future<Either<Failure, Success>> call(Params params) async {
    return (await _databaseRepository.addWord(params.entity, params.folderName)).fold(
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
