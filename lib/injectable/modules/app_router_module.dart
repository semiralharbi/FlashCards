import 'package:injectable/injectable.dart';

import '../../app/utils/router/app_router.gr.dart';


@module
abstract class AppRouterModule {
  @lazySingleton
  AppRouter get instance => AppRouter();
}
