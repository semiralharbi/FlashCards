// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class Translation {
  Translation();

  static Translation? _current;

  static Translation get current {
    assert(_current != null,
        'No instance of Translation was loaded. Try to initialize the Translation delegate before accessing Translation.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<Translation> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = Translation();
      Translation._current = instance;

      return instance;
    });
  }

  static Translation of(BuildContext context) {
    final instance = Translation.maybeOf(context);
    assert(instance != null,
        'No instance of Translation present in the widget tree. Did you add Translation.delegate in localizationsDelegates?');
    return instance!;
  }

  static Translation? maybeOf(BuildContext context) {
    return Localizations.of<Translation>(context, Translation);
  }

  /// `Rejestracja`
  String get registration {
    return Intl.message(
      'Rejestracja',
      name: 'registration',
      desc: '',
      args: [],
    );
  }

  /// `Logowanie`
  String get login {
    return Intl.message(
      'Logowanie',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Nazwa użytkownika`
  String get username {
    return Intl.message(
      'Nazwa użytkownika',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `Wprowadź swoją nazwę użytkownika`
  String get usernameInsert {
    return Intl.message(
      'Wprowadź swoją nazwę użytkownika',
      name: 'usernameInsert',
      desc: '',
      args: [],
    );
  }

  /// `Hasło`
  String get password {
    return Intl.message(
      'Hasło',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Powtórz hasło`
  String get passwordRepeat {
    return Intl.message(
      'Powtórz hasło',
      name: 'passwordRepeat',
      desc: '',
      args: [],
    );
  }

  /// `Wprowadź swoje hasło`
  String get passwordInsert {
    return Intl.message(
      'Wprowadź swoje hasło',
      name: 'passwordInsert',
      desc: '',
      args: [],
    );
  }

  /// `Kontynuuj`
  String get continueNav {
    return Intl.message(
      'Kontynuuj',
      name: 'continueNav',
      desc: '',
      args: [],
    );
  }

  /// `Stwórz konto`
  String get createAcc {
    return Intl.message(
      'Stwórz konto',
      name: 'createAcc',
      desc: '',
      args: [],
    );
  }

  /// `Przejdź do rejestracji`
  String get goToRegister {
    return Intl.message(
      'Przejdź do rejestracji',
      name: 'goToRegister',
      desc: '',
      args: [],
    );
  }

  /// `Cofnij`
  String get undo {
    return Intl.message(
      'Cofnij',
      name: 'undo',
      desc: '',
      args: [],
    );
  }

  /// `E-mail`
  String get email {
    return Intl.message(
      'E-mail',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Wprowadź swój e-mail`
  String get emailInsert {
    return Intl.message(
      'Wprowadź swój e-mail',
      name: 'emailInsert',
      desc: '',
      args: [],
    );
  }

  /// `Zaloguj się`
  String get logIn {
    return Intl.message(
      'Zaloguj się',
      name: 'logIn',
      desc: '',
      args: [],
    );
  }

  /// `Przejdź do logowania`
  String get goToLogin {
    return Intl.message(
      'Przejdź do logowania',
      name: 'goToLogin',
      desc: '',
      args: [],
    );
  }

  /// `Coś poszło nie tak!`
  String get somethingWentWrong {
    return Intl.message(
      'Coś poszło nie tak!',
      name: 'somethingWentWrong',
      desc: '',
      args: [],
    );
  }

  /// `Witaj w FlashCards!\nZaloguj się lub stwórz konto aby kontynuować`
  String get welcome {
    return Intl.message(
      'Witaj w FlashCards!\nZaloguj się lub stwórz konto aby kontynuować',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<Translation> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'pl'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<Translation> load(Locale locale) => Translation.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
