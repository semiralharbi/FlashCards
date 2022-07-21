import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../../app/utils/enums/errors.dart';
import '../../../domain/data_source/remote/authentication_remote_source.dart';
import '../../../domain/utils/exception.dart';
import '../../dto/create_user_dto.dart';

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
}
