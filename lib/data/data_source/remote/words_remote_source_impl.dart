import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../app/utils/enums/errors.dart';
import '../../../domain/data_source/remote/words_remote_source.dart';
import '../../../domain/utils/exception.dart';
import '../../api/api_client.dart';
import '../../dto/words/everything_dto.dart';

@Injectable(as: WordsRemoteSource)
class WordsRemoteSourceImpl implements WordsRemoteSource {
  WordsRemoteSourceImpl(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<EverythingDto> getEverything(String word) async {
    try {
      return await _apiClient.getEverything(word);
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        throw ApiException(Errors.wordNotFound);
      } else {
        throw ApiException(Errors.unknownError);
      }
    }
  }
}
