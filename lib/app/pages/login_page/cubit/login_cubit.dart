import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/entities/login_entity.dart';
import '../../../../domain/use_case/get_user_profile_use_case.dart';
import '../../../../domain/use_case/login_use_case.dart';
import 'login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._loginUseCase, this._getUserProfileUseCase) : super(const LoginState.loaded());

  final LoginUseCase _loginUseCase;
  final GetUserProfileUseCase _getUserProfileUseCase;

  Future<void> onLoginButton(String email, String password) async {
    emit(const LoginState.loading());
    final result = await _loginUseCase(LoginEntity(email: email, password: password));

    result.fold(
      (l) {
        emit(LoginState.fail(error: l.error));
        emit(LoginState.loaded(email: email, password: password));
      },
      (r) async {
        final userProfile = await _getUserProfileUseCase();
        userProfile.fold(
          (l) {
            emit(LoginState.fail(error: l.error));
            emit(LoginState.loaded(email: email, password: password));
          },
          (userProfile) {
            if (userProfile.name == '') {
              emit(const LoginState.showUsernamePage());
            } else {
              emit(const LoginState.showHomePage());
            }
          },
        );
      },
    );
  }
}
