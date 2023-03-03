import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../app/utils/enums/errors.dart';
import '../../domain/data_source/remote/authentication_remote_source.dart';
import '../../domain/entities/create_user_entity.dart';
import '../../domain/entities/login_entity.dart';
import '../../domain/entities/update_user_entity.dart';
import '../../domain/repositories/authentication_repo.dart';
import '../../domain/utils/exception.dart';
import '../../domain/utils/failure.dart';
import '../../domain/utils/success.dart';
import '../dto/user/create_user_dto.dart';
import '../dto/user/login_dto.dart';
import '../dto/user/update_user_dto.dart';

@Injectable(as: AuthenticationRepo)
class AuthenticationRepoImpl implements AuthenticationRepo {
  AuthenticationRepoImpl(this._remoteSource);

  final AuthenticationRemoteSource _remoteSource;

  @override
  Future<Either<Failure, UserCredential>> createUser(
    CreateUserEntity entity,
  ) async {
    try {
      final createUser = await _remoteSource.createUser(CreateUserDto.fromEntity(entity));
      return Right(createUser);
    } on ApiException catch (e) {
      return Left(Failure(appError: e.failure));
    } catch (e) {
      return const Left(Failure(appError: Errors.unknownError));
    }
  }

  @override
  Future<Either<Failure, User>> login(LoginEntity entity) async {
    try {
      final user = await _remoteSource.login(LoginDto.fromEntity(entity));
      if (user != null) {
        return Right(user);
      } else {
        return const Left(Failure(appError: Errors.userNotFound));
      }
    } on ApiException catch (e) {
      return Left(Failure(appError: e.failure));
    } catch (e) {
      return const Left(Failure(appError: Errors.unknownError));
    }
  }

  @override
  Future<Either<Failure, Success>> updateUser(UpdateUserEntity entity) async {
    try {
      await _remoteSource.updateUser(UpdateUserDto.fromEntity(entity));
      return const Right(Success());
    } on ApiException catch (e) {
      return Left(Failure(appError: e.failure));
    } catch (e) {
      return const Left(Failure(appError: Errors.unknownError));
    }
  }
}
