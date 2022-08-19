import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../entities/login_entity.dart';
import '../repositories/authentication_repo.dart';
import '../utils/failure.dart';
import '../utils/use_case.dart';

@injectable
class LoginUseCase implements UseCase<User, LoginEntity> {
  const LoginUseCase(this._authenticationRepo);

  final AuthenticationRepo _authenticationRepo;

  @override
  Future<Either<Failure, User>> call(LoginEntity entity) async {
    return (await _authenticationRepo.login(entity)).fold(
      (failure) => Left(failure),
      (user) => Right(user),
    );
  }
}
