import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../dto/words/everything_dto.dart';

part 'api_client.g.dart';

@injectable
@RestApi()
abstract class ApiClient {
  @factoryMethod
  factory ApiClient(Dio dio) => _ApiClient(dio);

  ///Get
  @GET('{word}')
  Future<EverythingDto> getEverything(@Path('word') String word);

  ///Post
  @POST('')
  Future<String> examplePost();

  ///Put
  @PUT('')
  Future<String> examplePut();

  ///Delete
  @DELETE('')
  Future<String> exampleDelete();
}
