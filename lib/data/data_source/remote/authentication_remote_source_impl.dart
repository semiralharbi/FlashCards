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
      if (userId != null) {
        final dto = UserProfileDto(
          name: '',
          userId: userId!,
          initialLanguage: 'pl',
          userFolders: [],
          email: firebaseAuth.currentUser?.email ?? '',
          appLanguage: 'pl',
          nativeLanguage: 'pl',
          languageToLearn: 'en',
        );
        await firestore.collection("users").doc(userId).set(dto.toJson());
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
  Future<Success> login(LoginDto dto) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: dto.email,
        password: dto.password,
      );
      return const Success();
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
      final user = firebaseAuth.currentUser;
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
      await firebaseAuth.signOut();
      return const Success();
    } catch (e) {
      throw ApiException(Errors.somethingWentWrong);
    }
  }

  @override
  Future<Success> updateUser(UserProfileDto dto) async {
    try {
      if (userId != null) {
        final doc = await firestore.collection("users").doc(userId).get();
        if (doc.exists) {
          final UserProfileDto existingUserDoc = UserProfileDto.fromJson(doc.data()!);
          final updatedUserDoc = existingUserDoc.copyWith(
            name: dto.name.isNotEmpty ? dto.name : existingUserDoc.name,
            userId: dto.userId.isNotEmpty ? dto.userId : existingUserDoc.userId,
            initialLanguage: dto.initialLanguage.isNotEmpty ? dto.initialLanguage : existingUserDoc.initialLanguage,
            nativeLanguage: dto.nativeLanguage.isNotEmpty ? dto.nativeLanguage : existingUserDoc.nativeLanguage,
            appLanguage: dto.appLanguage.isNotEmpty ? dto.appLanguage : existingUserDoc.appLanguage,
            languageToLearn: dto.languageToLearn.isNotEmpty ? dto.languageToLearn : existingUserDoc.languageToLearn,
            userFolders: dto.userFolders.isNotEmpty ? dto.userFolders : existingUserDoc.userFolders,
            email: dto.email.isNotEmpty ? dto.email : existingUserDoc.email,
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

  @override
  Future<UserProfileDto> getUserProfile() async {
    try {
      if (userId != null) {
        final doc = await firestore.collection("users").doc(userId).get();
        if (doc.exists) {
          final UserProfileDto userDoc = UserProfileDto.fromJson(doc.data()!);
          return userDoc;
        } else {
          throw ApiException(Errors.somethingWentWrong);
        }
      } else {
        throw ApiException(Errors.userNotFound);
      }
    } catch (e) {
      throw ApiException(Errors.somethingWentWrong);
    }
  }

  @override
  Future<Success> deleteAccount() async {
    try {
      await firebaseAuth.currentUser?.delete();
      return const Success();
    } catch (e) {
      throw ApiException(Errors.somethingWentWrong);
    }
  }

  @override
  Future<Success> resetPassword(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      return const Success();
    } catch (e) {
      throw ApiException(Errors.somethingWentWrong);
    }
  }
}
