import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../app/utils/enums/errors.dart';
import '../../domain/data_source/remote/authentication_remote_source.dart';
import '../../domain/entities/create_user_entity.dart';
import '../../domain/repositories/authentication_repo.dart';
import '../../domain/utils/exception.dart';
import '../../domain/utils/failure.dart';
import '../dto/create_user_dto.dart';

@Injectable(as: AuthenticationRepo)
class AuthenticationRepoImpl implements AuthenticationRepo {
  AuthenticationRepoImpl(this._remoteSource);

  final AuthenticationRemoteSource _remoteSource;

  @override
  Future<Either<Failure, UserCredential>> createUser(
      CreateUserEntity entity) async {
    try {
      final createUser =
          await _remoteSource.createUser(CreateUserDto.fromEntity(entity));
      return Right(createUser);
    } on ApiException catch (e) {
      return Left(Failure(appError: e.failure));
    } catch (e) {
      return const Left(Failure(appError: Errors.unknownError));
    }
  }
}
