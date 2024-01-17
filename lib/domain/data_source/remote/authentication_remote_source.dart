import 'package:firebase_auth/firebase_auth.dart';

import '../../../data/dto/user/create_user_dto.dart';
import '../../../data/dto/user/login_dto.dart';
import '../../../data/dto/user/user_profile_dto.dart';
import '../../utils/success.dart';

abstract class AuthenticationRemoteSource {
  Future<UserCredential> createUser(
    CreateUserDto dto,
  );

  Future<Success> login(
    LoginDto dto,
  );

  Future<User> getCurrentUser();

  Future<Success> signOut();

  Future<Success> deleteAccount();

  Future<Success> resetPassword(String email);

  Future<Success> updateUser(
    UserProfileDto dto,
  );

  Future<UserProfileDto> getUserProfile();
}
