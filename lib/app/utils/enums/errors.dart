import 'package:flutter/material.dart';

import 'context_extension.dart';

enum Errors {
  unknownError,
  userNotFound,
  tryAgainLater,
  checkInternetConnection,
  somethingWentWrong,
  weakPassword,
  operationNotAllowed,
  emailInUse,
  invalidEmail,
  fieldCantBeEmpty,
  passwordMatch,
  userDisabled,
  wrongPassword,
  lackOfFolderDescription,
  wordNotFound,
  wrongEmail,
  documentForThisUserNotFound
}

extension ErrorsExtension on Errors {
  String errorText(BuildContext context) {
    switch (this) {
      case Errors.unknownError:
        return context.tr.unknownError;
      case Errors.documentForThisUserNotFound:
        return context.tr.documentForThisUserNotFound;
      case Errors.tryAgainLater:
        return context.tr.tryAgainLater;
      case Errors.checkInternetConnection:
        return context.tr.checkInternetConnetction;
      case Errors.somethingWentWrong:
        return context.tr.somethingWentWrong;
      case Errors.userNotFound:
        return context.tr.userNotFound;
      case Errors.weakPassword:
        return context.tr.weakPassword;
      case Errors.operationNotAllowed:
        return context.tr.operationNotAllowed;
      case Errors.emailInUse:
        return context.tr.emailInUse;
      case Errors.invalidEmail:
        return context.tr.invalidEmail;
      case Errors.fieldCantBeEmpty:
        return context.tr.fieldCantBeEmpty;
      case Errors.passwordMatch:
        return context.tr.passwordsMatch;
      case Errors.wrongPassword:
        return context.tr.wrongPassword;
      case Errors.userDisabled:
        return context.tr.userDisabled;
      case Errors.lackOfFolderDescription:
        return context.tr.lackOfFolderDescription;
      case Errors.wordNotFound:
        return context.tr.wordNotFound;
      case Errors.wrongEmail:
        return context.tr.wrongEmail;
      default:
        return context.tr.unknownError;
    }
  }
}
