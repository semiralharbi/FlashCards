import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app/theme/theme_manager.dart';
import 'app/utils/router/app_router.gr.dart';
import 'app/utils/translation/generated/l10n.dart';
import 'injectable/injectable.dart';

Future<void> main() async {
  configureDependencies();
  await _configureSystemUIOverlays();
  await _configureServices();
  runApp(FlashCardsApp());
}

Future<void> _configureSystemUIOverlays() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

Future<void> _configureServices() async {
  await Firebase.initializeApp();
}

class FlashCardsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: getIt<AppRouter>().delegate(),
      routeInformationParser: getIt<AppRouter>().defaultRouteParser(),
      localizationsDelegates: const [
        Translation.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pl', 'PL'),
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        if (locale == null) return supportedLocales.first;

        return supportedLocales.firstWhere(
              (e) =>
          e.languageCode == locale.languageCode &&
              e.countryCode == locale.countryCode,
          orElse: () => supportedLocales.firstWhere(
                (c) => c.languageCode == locale.languageCode,
            orElse: () => supportedLocales.first,
          ),
        );
      },
      theme: getIt<ThemeManager>().getTheme(),
    );
  }
}
