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
      final ref = database.collection("$userId");
      await ref.add({
        "folderName": dto.folderName,
        "words": dto.words.map((e) => e.toJson()).toList(),
        "correctAnswers": dto.words.where((e) => e.correctAnswer == true).length,
      });
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
      List<FlashcardDto> dto = allData.map((e) => FlashcardDto.fromJson(e)).toList();
      return dto;
    } catch (e) {
      print(e);
      throw ApiException(Errors.lackOfFolderDescription);
    }
  }
}
