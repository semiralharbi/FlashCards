import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/entities/create_user_entity.dart';
import '../../../../domain/use_case/create_user_use_case.dart';
import '../../../utils/enums/errors.dart';
import 'registration_page_state.dart';

@injectable
class RegistrationPageCubit extends Cubit<RegistrationPageState> {
  RegistrationPageCubit(this._createUserUseCase)
      : super(const RegistrationPageState.initial());

  final CreateUserUseCase _createUserUseCase;

  void onRegisterClick({
    required String email,
    required String password,
    required String repeatPassword,
  }) async {
    if (email.isNotEmpty &&
        password.isNotEmpty &&
        repeatPassword.compareTo(password) == 0) {
      final result = await _createUserUseCase(CreateUserEntity(
        email: email,
        password: password,
      ));
      result.fold(
        (l) {
          emit(RegistrationPageState.fail(
            error: l.appError,
          ));
          emit(const RegistrationPageState.content());
        },
        (r) => emit(
          const RegistrationPageState.registerSuccess(),
        ),
      );
    } else if (email.isEmpty) {
      emit(RegistrationPageState.content(
          email: email,
          password: password,
          repeatPassword: repeatPassword,
          emailError: Errors.fieldCantBeEmpty));
    } else if (password.isEmpty) {
      emit(RegistrationPageState.content(
          email: email,
          password: password,
          repeatPassword: repeatPassword,
          passwordError: Errors.fieldCantBeEmpty));
    } else if (repeatPassword.isEmpty) {
      emit(RegistrationPageState.content(
          email: email,
          password: password,
          repeatPassword: repeatPassword,
          repeatPasswordError: Errors.fieldCantBeEmpty));
    } else if (repeatPassword.compareTo(password) < 0) {
      emit(RegistrationPageState.content(
          email: email,
          password: password,
          repeatPassword: repeatPassword,
          passwordError: Errors.passwordMatch,
          repeatPasswordError: Errors.passwordMatch));
    } else {
      emit(const RegistrationPageState.fail(error: Errors.unknownError));
      emit(const RegistrationPageState.content());
    }
  }
}
