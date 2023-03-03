import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../environment_config.dart';

@module
abstract class ApiModule {
  @singleton
  Dio get client => Dio(
        BaseOptions(
          baseUrl: EnvConfig.wordsUrl,
          headers: {
            'X-RapidAPI-Key': EnvConfig.wordsApiKey,
          },
        ),
      )..interceptors.addAll(
          [
            PrettyDioLogger(
              requestHeader: true,
              requestBody: true,
              responseBody: true,
              responseHeader: false,
              error: true,
              compact: true,
              maxWidth: 120,
            ),
          ],
        );
}
