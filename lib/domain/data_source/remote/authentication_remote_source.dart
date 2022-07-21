import 'package:firebase_auth/firebase_auth.dart';

import '../../../data/dto/create_user_dto.dart';
import '../../../data/dto/login_dto.dart';
import '../../../data/dto/update_user_dto.dart';
import '../../utils/success.dart';

abstract class AuthenticationRemoteSource {
  Future<UserCredential> createUser(
    CreateUserDto dto,
  );

  Future<Success> updateUser(
    UpdateUserDto dto,
  );

  Future<User?> login(
    LoginDto dto,
  );
}
