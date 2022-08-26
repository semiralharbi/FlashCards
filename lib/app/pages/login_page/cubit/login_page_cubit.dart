import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/entities/login_entity.dart';
import '../../../../domain/use_case/login_use_case.dart';
import 'login_page_state.dart';

@injectable
class LoginPageCubit extends Cubit<LoginPageState> {
  LoginPageCubit(this._loginUseCase) : super(const LoginPageState.initial());

  final LoginUseCase _loginUseCase;

  Future<void> onLoginButton(String email, String password) async {
    final result = await _loginUseCase(
      LoginEntity(
        email: email,
        password: password,
      ),
    );
    result.fold(
      (l) {
        emit(LoginPageState.fail(error: l.appError));
        emit(LoginPageState.initial(email: email, password: password));
      },
      (r) {
        if (r.displayName == null) {
          emit(const LoginPageState.showUsernamePage());
        } else {
          emit(const LoginPageState.showHomePage());
        }
      },
    );
  }
}
