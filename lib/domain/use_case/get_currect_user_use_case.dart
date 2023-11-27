import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../repositories/authentication_repo.dart';
import '../utils/failure.dart';
import '../utils/use_case.dart';

@injectable
class GetCurrentUserUseCase implements NoParamsUseCaseWithFailure<User> {
  const GetCurrentUserUseCase(this._authenticationRepository);

  final AuthenticationRepo _authenticationRepository;

  @override
  Future<Either<Failure, User>> call() async {
    return (await _authenticationRepository.getCurrentUser()).fold(
      (failure) => Left(failure),
      (r) => Right(r),
    );
  }
}
