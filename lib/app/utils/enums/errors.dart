import 'package:flutter/material.dart';

import '../translation/generated/l10n.dart';

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
}

extension ErrorsExtension on Errors {
  String errorText(BuildContext context) {
    switch (this) {
      case Errors.unknownError:
        return Translation.of(context).unknownError;
      case Errors.tryAgainLater:
        return Translation.of(context).tryAgainLater;
      case Errors.checkInternetConnection:
        return Translation.of(context).checkInternetConnetction;
      case Errors.somethingWentWrong:
        return Translation.of(context).somethingWentWrong;
      case Errors.userNotFound:
        return Translation.of(context).userNotFound;
      case Errors.weakPassword:
        return Translation.of(context).weakPassword;
      case Errors.operationNotAllowed:
        return Translation.of(context).operationNotAllowed;
      case Errors.emailInUse:
        return Translation.of(context).emailInUse;
      case Errors.invalidEmail:
        return Translation.of(context).invalidEmail;
      case Errors.fieldCantBeEmpty:
        return Translation.of(context).fieldCantBeEmpty;
      case Errors.passwordMatch:
        return Translation.of(context).passwordsMatch;

      default:
        return Translation.of(context).unknownError;
    }
  }
}
