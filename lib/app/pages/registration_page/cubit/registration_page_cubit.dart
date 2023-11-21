import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/entities/create_user_entity.dart';
import '../../../../domain/use_case/create_user_use_case.dart';
import '../../../utils/enums/errors.dart';
import '../models/validation_errors.dart';
import 'registration_page_state.dart';

@injectable
class RegistrationPageCubit extends Cubit<RegistrationPageState> {
  RegistrationPageCubit(this._createUserUseCase) : super(const RegistrationPageState.initial());

  final CreateUserUseCase _createUserUseCase;

  Future<void> onRegisterClick({
    required String email,
    required String password,
    required String repeatPassword,
  }) async {
    emit(const RegistrationPageState.loading());

    final validationErrors = _validateInput(email, password, repeatPassword);
    final passwordsMatch = repeatPassword.compareTo(password) == 0;
    final fulfilledConditions = email.isNotEmpty && password.isNotEmpty && passwordsMatch;

    if (validationErrors != null) {
      return emit(
        RegistrationPageState.content(
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
          error: l.appError,
          email: email,
          password: password,
          repeatPassword: repeatPassword,
        ),
        (r) => emit(const RegistrationPageState.registerSuccess()),
      );
    } else {
      return _emitFailureThenContentState(error: Errors.unknownError);
    }
  }

  void _emitFailureThenContentState({
    Errors? error,
    String? email,
    String? password,
    String? repeatPassword,
  }) {
    emit(RegistrationPageState.fail(error: error));
    emit(RegistrationPageState.content(email: email, password: password, repeatPassword: repeatPassword));
  }

  ValidationErrors? _validateInput(String email, String password, String repeatPassword) {
    if (email.isEmpty) {
      return const ValidationErrors(emailError: Errors.fieldCantBeEmpty);
    } else if (password.isEmpty || repeatPassword.isEmpty) {
      return const ValidationErrors(passwordError: Errors.fieldCantBeEmpty, repeatPasswordError: Errors.fieldCantBeEmpty);
    } else if (password != repeatPassword) {
      return const ValidationErrors(passwordError: Errors.passwordMatch, repeatPasswordError: Errors.passwordMatch);
    }
    return null;
  }
}
