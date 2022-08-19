import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';


part 'api_client.g.dart';

@injectable
@RestApi(baseUrl: 'https://www.thecocktaildb.com')
abstract class ApiClient {
  @factoryMethod
  factory ApiClient(Dio dio) => _ApiClient(dio);

//Get method
  @GET('')
  Future<String> exampleGet();

//Post method
  @POST('')
  Future<String> examplePost();

//Put method
  @PUT('')
  Future<String> examplePut();

//Delete method
  @DELETE('')
  Future<String> exampleDelete();
}
