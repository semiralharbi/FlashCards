import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app/pages/cubit/app_cubit.dart';
import 'app/pages/cubit/app_state.dart';
import 'app/theme/global_imports.dart';
import 'app/theme/theme_manager.dart';
import 'app/utils/translation/generated/l10n.dart';
import 'firebase_options.dart';
import 'injectable/injectable.dart';

Future<void> main() async {
  await _configureSystemUIOverlays();
  await _configureServices();
  configureDependencies();
  runApp(const FlashCardsApp());
}

Future<void> _configureSystemUIOverlays() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

Future<void> _configureServices() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class FlashCardsApp extends StatelessWidget {
  const FlashCardsApp({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => getIt<AppCubit>(),
        child: BlocListener<AppCubit, AppState>(
          listener: (context, state) => state.whenOrNull(
            toHomePage: () => getIt<AppRouter>().push(HomeRoute()),
            toUsernamePage: () => getIt<AppRouter>().push(const UsernameRoute()),
          ),
          child: MaterialApp.router(
            routerConfig: getIt<AppRouter>().config(),
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
                (e) => e.languageCode == locale.languageCode && e.countryCode == locale.countryCode,
                orElse: () => supportedLocales.firstWhere(
                  (c) => c.languageCode == locale.languageCode,
                  orElse: () => supportedLocales.first,
                ),
              );
            },
            theme: getIt<ThemeManager>().getTheme(),
          ),
        ),
      );
}
