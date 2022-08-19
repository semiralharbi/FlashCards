import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../entities/update_user_entity.dart';
import '../repositories/authentication_repo.dart';
import '../utils/failure.dart';
import '../utils/success.dart';
import '../utils/use_case.dart';

@injectable
class UpdateUserUseCase implements UseCase<Success, UpdateUserEntity> {
  const UpdateUserUseCase(this._authenticationRepo);

  final AuthenticationRepo _authenticationRepo;

  @override
  Future<Either<Failure, Success>> call(UpdateUserEntity entity) async {
    return (await _authenticationRepo.updateUser(entity)).fold(
      (failure) => Left(failure),
      (r) => const Right(Success()),
    );
  }
}
