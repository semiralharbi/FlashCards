import 'package:auto_route/annotations.dart';

import '../../pages/home_page/home_page.dart';
import '../../pages/registration_page/registration_page.dart';
import '../../pages/username_page/username_page.dart';

export 'app_router.gr.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: HomePage, initial: true),
    AutoRoute(page: RegistrationPage),
    AutoRoute(page: UsernamePage),
  ],
)
class $AppRouter {}
