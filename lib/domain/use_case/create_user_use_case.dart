import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../entities/create_user_entity.dart';
import '../repositories/authentication_repo.dart';
import '../utils/failure.dart';
import '../utils/success.dart';
import '../utils/use_case.dart';

@injectable
class CreateUserUseCase implements UseCase<Success, CreateUserEntity> {
  const CreateUserUseCase(this._authenticationRepo);

  final AuthenticationRepo _authenticationRepo;

  @override
  Future<Either<Failure, Success>> call(CreateUserEntity entity) async {
    return (await _authenticationRepo.createUser(entity)).fold(
      (failure) => Left(failure),
      (r) => const Right(Success()),
    );
  }
}
