import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../entities/login_entity.dart';
import '../repositories/authentication_repo.dart';
import '../utils/failure.dart';
import '../utils/success.dart';
import '../utils/use_case.dart';

@injectable
class LoginUseCase implements UseCase<Success, LoginEntity> {
  const LoginUseCase(this._authenticationRepo);

  final AuthenticationRepo _authenticationRepo;

  @override
  Future<Either<Failure, Success>> call(LoginEntity entity) async {
    return (await _authenticationRepo.login(entity)).fold(
      (failure) => Left(failure),
      (success) => Right(success),
    );
  }
}
