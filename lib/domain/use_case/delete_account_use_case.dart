import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../repositories/authentication_repo.dart';
import '../utils/failure.dart';
import '../utils/success.dart';
import '../utils/use_case.dart';

@injectable
class DeleteAccountUseCase implements NoParamsUseCaseWithFailure<Success> {
  const DeleteAccountUseCase(this._authenticationRepository);

  final AuthenticationRepo _authenticationRepository;

  @override
  Future<Either<Failure, Success>> call() async {
    return (await _authenticationRepository.deleteAccount()).fold(
      (failure) => Left(failure),
      (r) => Right(r),
    );
  }
}
