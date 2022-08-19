import 'package:injectable/injectable.dart';

import '../../../domain/data_source/local/authentication_local_source.dart';

@Singleton(as: AuthenticationLocalSource)
class AuthenticationLocalSourceImpl implements AuthenticationLocalSource {
  AuthenticationLocalSourceImpl();
}
