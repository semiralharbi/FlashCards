import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../entities/words/everything_entity.dart';
import '../repositories/words_repository.dart';
import '../utils/failure.dart';
import '../utils/use_case.dart';

@injectable
class GetWordInfoUseCase implements UseCase<EverythingEntity, String> {
  const GetWordInfoUseCase(this._wordsRepository);

  final WordsRepository _wordsRepository;

  @override
  Future<Either<Failure, EverythingEntity>> call(String word) async {
    return (await _wordsRepository.getEverything(word)).fold(
      (failure) => Left(failure),
      (r) => Right(r),
    );
  }
}
