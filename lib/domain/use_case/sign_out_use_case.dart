import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../repositories/authentication_repo.dart';
import '../utils/failure.dart';
import '../utils/success.dart';
import '../utils/use_case.dart';

@injectable
class SingOutUseCase implements NoParamsUseCaseWithFailure<Success> {
  const SingOutUseCase(this._authenticationRepository);

  final AuthenticationRepo _authenticationRepository;

  @override
  Future<Either<Failure, Success>> call() async {
    return (await _authenticationRepository.signOut()).fold(
      (failure) => Left(failure),
      (r) => Right(r),
    );
  }
}
