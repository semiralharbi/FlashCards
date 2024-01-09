import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../repositories/authentication_repo.dart';
import '../utils/failure.dart';
import '../utils/success.dart';
import '../utils/use_case.dart';

@injectable
class ResetPasswordUseCase implements UseCase<Success, String> {
  const ResetPasswordUseCase(this._authenticationRepository);

  final AuthenticationRepo _authenticationRepository;

  @override
  Future<Either<Failure, Success>> call(String email) async {
    return (await _authenticationRepository.resetPassword(email)).fold(
      (failure) => Left(failure),
      (r) => Right(r),
    );
  }
}
