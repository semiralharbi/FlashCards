import '../../app/utils/enums/errors.dart';

class ApiException implements Exception {
  ApiException(this.failure);

  Errors failure;
}
