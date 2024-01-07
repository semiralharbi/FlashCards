import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../entities/create_user_entity.dart';
import '../entities/login_entity.dart';
import '../entities/user/user_profile_entity.dart';
import '../utils/failure.dart';
import '../utils/success.dart';

abstract class AuthenticationRepo {
  Future<Either<Failure, UserCredential>> createUser(
    CreateUserEntity entity,
  );

  Future<Either<Failure, Success>> login(
    LoginEntity entity,
  );

  Future<Either<Failure, User>> getCurrentUser();

  Future<Either<Failure, Success>> signOut();
  Future<Either<Failure, Success>> updateUserProfile(UserProfileEntity entity);
  Future<Either<Failure, UserProfileEntity>> getUserProfile();
}
