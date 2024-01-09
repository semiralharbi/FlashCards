import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../entities/user/user_profile_entity.dart';
import '../repositories/authentication_repo.dart';
import '../utils/failure.dart';
import '../utils/use_case.dart';

@injectable
class GetUserProfileUseCase implements NoParamsUseCaseWithFailure<UserProfileEntity> {
  const GetUserProfileUseCase(this._authenticationRepository);

  final AuthenticationRepo _authenticationRepository;

  @override
  Future<Either<Failure, UserProfileEntity>> call() async {
    return (await _authenticationRepository.getUserProfile()).fold(
      (failure) => Left(failure),
      (entity) => Right(entity),
    );
  }
}
