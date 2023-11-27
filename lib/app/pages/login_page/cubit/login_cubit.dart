import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/entities/login_entity.dart';
import '../../../../domain/use_case/login_use_case.dart';
import 'login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._loginUseCase) : super(const LoginState.loaded());

  final LoginUseCase _loginUseCase;

  Future<void> onLoginButton(String email, String password) async {
    emit(const LoginState.loading());
    final result = await _loginUseCase(
      LoginEntity(
        email: email,
        password: password,
      ),
    );
    result.fold(
      (l) {
        emit(LoginState.fail(error: l.error));
        emit(LoginState.loaded(email: email, password: password));
      },
      (r) {
        if (r.displayName == null || r.displayName!.isEmpty) {
          emit(const LoginState.showUsernamePage());
        } else {
          emit(const LoginState.showHomePage());
        }
      },
    );
  }
}
