import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../../app/utils/enums/errors.dart';
import '../../../domain/data_source/remote/database_remote_source.dart';
import '../../../domain/utils/exception.dart';
import '../../../domain/utils/success.dart';
import '../../dto/database/flashcard_dto.dart';

@Injectable(as: DatabaseRemoteSource)
class DatabaseRemoteSourceImpl implements DatabaseRemoteSource {
  final database = FirebaseFirestore.instance;
  final userId = FirebaseAuth.instance.currentUser?.uid;

  @override
  Future<Success> newFolder(FlashcardDto dto) async {
    if (userId != null) {
      await database.collection("$userId").doc(dto.folderName.toUpperCase()).set(dto.toJson());
      return const Success();
    } else {
      throw ApiException(Errors.somethingWentWrong);
    }
  }

  @override
  Future<List<FlashcardDto>> getCollection() async {
    try {
      QuerySnapshot<Map<String, dynamic>> collection = await database.collection('$userId').get();
      List<Map<String, dynamic>> allData = collection.docs.map((e) => e.data()).toList();
      if (allData.isNotEmpty) {
        List<FlashcardDto> dto = allData.map((e) => FlashcardDto.fromJson(e)).toList();
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
  Future<Success> updateCollection(FlashcardDto dto) async {
    try {
      database.collection("$userId").doc(dto.folderName.toUpperCase()).set(dto.toJson());
      return const Success();
    } catch (e) {
      throw ApiException(Errors.somethingWentWrong);
    }
  }
}
