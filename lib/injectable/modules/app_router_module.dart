import 'package:injectable/injectable.dart';

import '../../app/utils/router/app_router.dart';

@module
abstract class AppRouterModule {
  @singleton
  AppRouter get instance => AppRouter();
}
