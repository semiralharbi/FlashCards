import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../entities/database/folder_entity.dart';
import '../repositories/database_repository.dart';
import '../utils/failure.dart';
import '../utils/success.dart';
import '../utils/use_case.dart';

@injectable
class DeleteWordUseCase implements UseCase<Success, Params> {
  const DeleteWordUseCase(this._databaseRepository);

  final DatabaseRepository _databaseRepository;

  @override
  Future<Either<Failure, Success>> call(Params params) async {
    return (await _databaseRepository.deleteWord(params.entity, params.index)).fold(
      (failure) => Left(failure),
      (r) => const Right(Success()),
    );
  }
}

@immutable
class Params {
  const Params(this.index, this.entity);

  final int index;
  final FolderEntity entity;
}
