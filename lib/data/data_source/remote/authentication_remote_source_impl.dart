import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../../app/utils/enums/errors.dart';
import '../../../domain/data_source/remote/authentication_remote_source.dart';
import '../../../domain/utils/exception.dart';
import '../../../domain/utils/success.dart';
import '../../dto/user/create_user_dto.dart';
import '../../dto/user/login_dto.dart';
import '../../dto/user/user_profile_dto.dart';

@Injectable(as: AuthenticationRemoteSource)
class AuthenticationRemoteSourceImpl implements AuthenticationRemoteSource {
  AuthenticationRemoteSourceImpl(this.firestore, this.firebaseAuth);

  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;
  String? get userId => firebaseAuth.currentUser?.uid;

  @override
  Future<UserCredential> createUser(CreateUserDto dto) async {
    try {
      final user = await firebaseAuth.createUserWithEmailAndPassword(
        email: dto.email,
        password: dto.password,
      );
      if (user.user != null) {
        final userId = user.user!.uid;
        await firestore.collection("users").doc(userId).set(
              UserProfileDto(name: '', userId: user.user!.uid, initialLanguage: 'pl', userFolders: []).toJson(),
            );
      }
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
  Future<User> getCurrentUser() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        return user;
      } else {
        throw ApiException(Errors.userNotFound);
      }
    } catch (e) {
      throw ApiException(Errors.somethingWentWrong);
    }
  }

  @override
  Future<Success> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      return const Success();
    } catch (e) {
      throw ApiException(Errors.somethingWentWrong);
    }
  }
  @override
  Future<Success> userFolders(UserProfileDto dto) async {
    try {
      if (userId != null) {
        final doc = await firestore.collection("users").doc(userId).get();
        if (doc.exists) {
          final UserProfileDto existingUserDoc = UserProfileDto.fromJson(doc.data()!);
          final updatedUserDoc = existingUserDoc.copyWith(
            name: dto.name.isNotEmpty ? dto.name : existingUserDoc.name,
            userId: dto.userId.isNotEmpty ? dto.userId : existingUserDoc.userId,
            initialLanguage: dto.initialLanguage.isNotEmpty ? dto.initialLanguage : existingUserDoc.initialLanguage,
            userFolders: dto.userFolders.isNotEmpty ? dto.userFolders : existingUserDoc.userFolders,
          );
          await firestore.collection("users").doc(userId).set(updatedUserDoc.toJson());
        } else {
          await firestore.collection("users").doc(userId).set(dto.toJson());
        }
        return const Success();
      } else {
        throw ApiException(Errors.userNotFound);
      }
    } catch (e) {
      throw ApiException(Errors.somethingWentWrong);
    }
  }


}
