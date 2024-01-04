import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../entities/user/user_profile_entity.dart';
import '../repositories/authentication_repo.dart';
import '../utils/failure.dart';
import '../utils/success.dart';
import '../utils/use_case.dart';

@injectable
class UpdateUserProfileUseCase implements UseCase<Success, UserProfileEntity> {
  const UpdateUserProfileUseCase(this._authenticationRemoteSource);

  final AuthenticationRepo _authenticationRemoteSource;

  @override
  Future<Either<Failure, Success>> call(UserProfileEntity entity) async {
    return (await _authenticationRemoteSource.updateUserProfile(entity)).fold(
      (failure) => Left(failure),
      (r) => const Right(Success()),
    );
  }
}
