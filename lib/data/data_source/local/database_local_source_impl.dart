// import 'dart:convert';
//
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:injectable/injectable.dart';
//
// import '../../../app/utils/enums/errors.dart';
// import '../../../domain/data_source/local/database_local_source.dart';
// import '../../../domain/entities/database/words_entity.dart';
// import '../../../domain/utils/exception.dart';
//
// @Singleton(as: DatabaseLocalSource)
// class DatabaseLocalSourceImpl implements DatabaseLocalSource {
//   DatabaseLocalSourceImpl(this._flutterSecureStorage);
//
//   final FlutterSecureStorage _flutterSecureStorage;
//   final String _answersKey = 'cardsAnswers';
//
//   @override
//   Future<void> clearCardsAnswers() {
//     _flutterSecureStorage.delete(key: _answersKey);
//     throw UnimplementedError();
//   }
//
//   @override
//   Future<List<WordsEntity>> getCardsAnswers() async {
//     final result = await _flutterSecureStorage.read(key: _answersKey);
//     if (result != null) {
//       final data = (jsonDecode(result) as List).map((e) => WordsEntity.fromJson(e)).toList();
//       return data;
//     } else {
//       throw ApiException(Errors.unknownError);
//     }
//   }
//
//   @override
//   Future<void> saveCardsAnswers(List<WordsEntity> entity) async {
//     await _flutterSecureStorage.write(
//       key: _answersKey,
//       value: jsonEncode(
//         entity.map((e) => e.toJson()).toList(),
//       ),
//     );
//   }
// }
