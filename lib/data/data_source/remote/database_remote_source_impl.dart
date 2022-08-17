import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:injectable/injectable.dart';

import '../../../app/utils/enums/errors.dart';
import '../../../domain/data_source/remote/database_remote_source.dart';
import '../../../domain/utils/exception.dart';
import '../../../domain/utils/success.dart';
import '../../dto/database/flashcard_dto.dart';

@Injectable(as: DatabaseRemoteSource)
class DatabaseRemoteSourceImpl implements DatabaseRemoteSource {
  FirebaseDatabase database = FirebaseDatabase.instance;

  @override
  Future<Success> newFolder(FlashcardDto dto) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      final ref = database.ref("users/$userId/${dto.folderName}");
      await ref.set({
        "enWord": dto.enWord,
        "translatedWord": dto.translatedWord,
        "nrRepeated": dto.nrRepeated,
        "correctAnswer": dto.correctAnswer,
      });
      return const Success();
    } else {
      throw ApiException(Errors.somethingWentWrong);
    }
  }
}
