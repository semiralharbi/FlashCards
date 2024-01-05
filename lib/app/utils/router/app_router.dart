import 'dart:core';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/database/folder_entity.dart';
import '../../../domain/entities/database/words_entity.dart';
import '../../../domain/entities/user/user_profile_entity.dart';
import '../../pages/add_folder_words_page/add_folder_words_page.dart';
import '../../pages/create_folder_page/create_folder_page.dart';
import '../../pages/dictionary_page/dictionary_page.dart';
import '../../pages/edit_words_page/edit_words_page.dart';
import '../../pages/flashcard_page/flashcard_page.dart';
import '../../pages/folder_content_page/folder_content_page.dart';
import '../../pages/home_page/home_page.dart';
import '../../pages/login_page/login_page.dart';
import '../../pages/registration_page/registration_page.dart';
import '../../pages/result_page/result_page.dart';
import '../../pages/user_profile_page/user_profile_page.dart';
import '../../pages/username_page/username_page.dart';
import 'cubit_imports.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: LoginRoute.page, initial: true),
        AutoRoute(page: RegistrationRoute.page),
        AutoRoute(page: UsernameRoute.page),
        AutoRoute(page: HomeRoute.page),
        AutoRoute(page: FolderContentRoute.page),
        AutoRoute(page: FlashcardRoute.page),
        AutoRoute(page: ResultRoute.page),
        AutoRoute(page: EditWordsRoute.page),
        AutoRoute(page: DictionaryRoute.page),
        AutoRoute(page: CreateFolderRoute.page),
        AutoRoute(page: AddFolderWordsRoute.page),
        AutoRoute(page: UserProfileRoute.page),
      ];
}
