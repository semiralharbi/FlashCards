import 'package:firebase_auth/firebase_auth.dart';
import '../../../data/dto/user/create_user_dto.dart';
import '../../../data/dto/user/login_dto.dart';
import '../../../data/dto/user/user_profile_dto.dart';
import '../../utils/success.dart';

abstract class AuthenticationRemoteSource {
  Future<UserCredential> createUser(
    CreateUserDto dto,
  );

  Future<User?> login(
    LoginDto dto,
  );

  Future<User> getCurrentUser();

  Future<Success> signOut();

  Future<Success> updateUser(
    UserProfileDto dto,
  );
}
