import 'package:equatable/equatable.dart';

import '../../../utils/enums/errors.dart';

class ValidationErrors extends Equatable {
  const ValidationErrors({
    this.emailError,
    this.passwordError,
    this.repeatPasswordError,
  });

  final Errors? emailError;
  final Errors? passwordError;
  final Errors? repeatPasswordError;

  @override
  List<Object?> get props => [
        emailError,
        passwordError,
        repeatPasswordError,
      ];
}
