import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../../app/utils/enums/errors.dart';
import '../../../domain/data_source/remote/database_remote_source.dart';
import '../../../domain/utils/exception.dart';
import '../../../domain/utils/success.dart';
import '../../dto/database/folder_dto.dart';
import '../../dto/database/words_dto.dart';
import '../../dto/user/user_profile_dto.dart';

@Injectable(as: DatabaseRemoteSource)
class DatabaseRemoteSourceImpl implements DatabaseRemoteSource {
  DatabaseRemoteSourceImpl(this.firestore, this.firebaseAuth);
  final database = FirebaseFirestore.instance;
  final userId = FirebaseAuth.instance.currentUser?.uid;
  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;
  @override
  Future<Success> newFolder(FolderDto dto) async {
    if (userId != null) {
      await database.collection("$userId").doc(dto.folderName.toUpperCase()).set(dto.toJson());
      return const Success();
    } else {
      throw ApiException(Errors.somethingWentWrong);
    }
  }

  @override
  Future<List<FolderDto>> getCollection() async {
    try {
      QuerySnapshot<Map<String, dynamic>> collection = await database.collection('$userId').get();
      List<Map<String, dynamic>> allData = collection.docs.map((e) => e.data()).toList();
      if (allData.isNotEmpty) {
        List<FolderDto> dto = allData.map((e) => FolderDto.fromJson(e)).toList();
        dto.sort((a, b) => a.folderName.toLowerCase().compareTo(b.folderName.toLowerCase()));
        return dto;
      } else {
        throw ApiException(Errors.lackOfFolderDescription);
      }
    } catch (e) {
      throw ApiException(Errors.lackOfFolderDescription);
    }
  }

  @override
  Future<Success> updateCollection(FolderDto dto) async {
    try {
      database.collection("$userId").doc(dto.folderName.toUpperCase()).set(dto.toJson());
      return const Success();
    } catch (e) {
      throw ApiException(Errors.somethingWentWrong);
    }
  }

  @override
  Future<Success> deleteCollection(FolderDto dto) async {
    try {
      await database.collection("$userId").doc(dto.folderName.toUpperCase()).delete();
      return const Success();
    } catch (e) {
      throw ApiException(Errors.somethingWentWrong);
    }
  }

  @override
  Future<Success> deleteWord(FolderDto dto, int index) async {
    try {
      await database.collection("$userId").doc(dto.folderName.toUpperCase()).update({
        "words": FieldValue.arrayRemove([dto.words[index].toJson()]),
      });
      return const Success();
    } catch (e) {
      throw ApiException(Errors.somethingWentWrong);
    }
  }

  @override
  Future<Success> addWord(WordsDto dto, String folderName) async {
    try {
      await database.collection("$userId").doc(folderName.toUpperCase()).update({
        "words": FieldValue.arrayUnion([dto.toJson()]),
      });
      return const Success();
    } catch (e) {
      throw ApiException(Errors.somethingWentWrong);
    }
  }

  @override
  Future<Success> editWord(WordsDto dto, String folderName) async {
    try {
      await database.collection("$userId").doc(folderName.toUpperCase()).update({
        "words": FieldValue.arrayUnion([dto.toJson()]),
      });
      return const Success();
    } catch (e) {
      throw ApiException(Errors.somethingWentWrong);
    }
  }
  @override
  Future<Success> updateUserProfile(UserProfileDto dto) async {
    try {
      final userId = firebaseAuth.currentUser?.uid;
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
