import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../entities/user/user_profile_entity.dart';
import '../repositories/database_repository.dart';
import '../utils/failure.dart';
import '../utils/success.dart';
import '../utils/use_case.dart';

@injectable
class UpdateUserProfileUseCase implements UseCase<Success, UserProfileEntity> {
  const UpdateUserProfileUseCase(this._databaseRepo);

  final DatabaseRepository _databaseRepo;

  @override
  Future<Either<Failure, Success>> call(UserProfileEntity entity) async {
    return (await _databaseRepo.updateUserProfile(entity)).fold(
      (failure) => Left(failure),
      (r) => const Right(Success()),
    );
  }
}
