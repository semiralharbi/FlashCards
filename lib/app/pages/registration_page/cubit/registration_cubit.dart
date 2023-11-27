import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/entities/create_user_entity.dart';
import '../../../../domain/use_case/create_user_use_case.dart';
import '../../../utils/enums/errors.dart';
import '../models/validation_errors.dart';
import 'registration_state.dart';

@injectable
class RegistrationCubit extends Cubit<RegistrationState> {
  RegistrationCubit(this._createUserUseCase) : super(const RegistrationState.loaded());

  final CreateUserUseCase _createUserUseCase;

  Future<void> onRegisterClick({
    required String email,
    required String password,
    required String repeatPassword,
  }) async {
    emit(const RegistrationState.loading());

    final validationErrors = _validateInput(email, password, repeatPassword);
    final passwordsMatch = repeatPassword.compareTo(password) == 0;
    final fulfilledConditions = email.isNotEmpty && password.isNotEmpty && passwordsMatch;

    if (validationErrors != null) {
      return emit(
        RegistrationState.loaded(
          email: email,
          password: password,
          repeatPassword: repeatPassword,
          emailError: validationErrors.emailError,
          passwordError: validationErrors.passwordError,
          repeatPasswordError: validationErrors.repeatPasswordError,
        ),
      );
    }

    if (fulfilledConditions) {
      final result = await _createUserUseCase(
        CreateUserEntity(
          email: email,
          password: password,
        ),
      );
      return result.fold(
        (l) => _emitFailureThenContentState(
          error: l.error,
          email: email,
          password: password,
          repeatPassword: repeatPassword,
        ),
        (r) => emit(const RegistrationState.success()),
      );
    }
  }

  void _emitFailureThenContentState({
    required Errors error,
    String? email,
    String? password,
    String? repeatPassword,
  }) {
    emit(RegistrationState.fail(error: error));
    emit(RegistrationState.loaded(email: email, password: password, repeatPassword: repeatPassword));
  }

  ValidationErrors? _validateInput(String email, String password, String repeatPassword) {
    if (email.isEmpty) {
      return const ValidationErrors(emailError: Errors.fieldCantBeEmpty);
    } else if (password.isEmpty || repeatPassword.isEmpty) {
      return const ValidationErrors(
        passwordError: Errors.fieldCantBeEmpty,
        repeatPasswordError: Errors.fieldCantBeEmpty,
      );
    } else if (password != repeatPassword) {
      return const ValidationErrors(passwordError: Errors.passwordMatch, repeatPasswordError: Errors.passwordMatch);
    }
    return null;
  }
}
