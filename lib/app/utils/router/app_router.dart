import 'package:auto_route/auto_route.dart';

import '../../pages/flashcard_page/flashcard_page.dart';
import '../../pages/folder_content_page/folder_content_page.dart';
import '../../pages/home_page/home_page.dart';
import '../../pages/login_page/login_page.dart';
import '../../pages/registration_page/registration_page.dart';
import '../../pages/username_page/username_page.dart';

export 'app_router.gr.dart';

@CustomAutoRouter(
  replaceInRouteName: 'Page,Route',
  transitionsBuilder: TransitionsBuilders.fadeIn,
  durationInMilliseconds: 400,
  routes: <AutoRoute>[
    AutoRoute(page: LoginPage, initial: true),
    AutoRoute(page: RegistrationPage),
    AutoRoute(page: UsernamePage),
    AutoRoute(page: HomePage),
    AutoRoute(page: FolderContentPage),
    AutoRoute(page: FlashcardPage),
  ],
)
class $AppRouter {}
