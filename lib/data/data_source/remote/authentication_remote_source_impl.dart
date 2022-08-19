import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../../app/utils/enums/errors.dart';
import '../../../domain/data_source/remote/authentication_remote_source.dart';
import '../../../domain/utils/exception.dart';
import '../../../domain/utils/success.dart';
import '../../dto/create_user_dto.dart';
import '../../dto/login_dto.dart';
import '../../dto/update_user_dto.dart';

@Injectable(as: AuthenticationRemoteSource)
class AuthenticationRemoteSourceImpl implements AuthenticationRemoteSource {
  @override
  Future<UserCredential> createUser(CreateUserDto dto) async {
    try {
      final user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: dto.email,
        password: dto.password,
      );
      return user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'weak-password':
          throw ApiException(Errors.weakPassword);
        case 'email-already-in-use':
          throw ApiException(Errors.emailInUse);
        case 'invalid-email':
          throw ApiException(Errors.invalidEmail);
        case 'operation-not-allowed':
          throw ApiException(Errors.operationNotAllowed);
        case 'unknown':
          throw ApiException(Errors.unknownError);
        default:
          rethrow;
      }
    } on ApiException catch (e) {
      throw ApiException(e.failure);
    }
  }

  @override
  Future<User> login(LoginDto dto) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: dto.email,
        password: dto.password,
      );
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        return user;
      } else {
        throw ApiException(Errors.unknownError);
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-disabled':
          throw ApiException(Errors.userDisabled);
        case 'user-not-found':
          throw ApiException(Errors.userNotFound);
        case 'invalid-email':
          throw ApiException(Errors.invalidEmail);
        case 'wrong-password':
          throw ApiException(Errors.wrongPassword);
        case 'unknown':
          throw ApiException(Errors.unknownError);
        default:
          rethrow;
      }
    } on ApiException catch (e) {
      throw ApiException(e.failure);
    }
  }

  @override
  Future<Success> updateUser(UpdateUserDto dto) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.updateDisplayName(dto.username);
        return const Success();
      } else {
        throw ApiException(Errors.unknownError);
      }
    } on ApiException catch (e) {
      throw ApiException(e.failure);
    }
  }
}
