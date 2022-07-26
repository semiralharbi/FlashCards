import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/entities/login_entity.dart';
import '../../../../domain/use_case/login_use_case.dart';
import 'home_page_state.dart';

@injectable
class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit(this._loginUseCase) : super(const HomePageState.initial());

  final LoginUseCase _loginUseCase;

  void onLoginButton(String email, String password) async {
    final result = await _loginUseCase(LoginEntity(
      email: email,
      password: password,
    ));
    result.fold(
      (l) {
        emit(HomePageState.fail(error: l.appError));
        emit(HomePageState.initial(email: email, password: password));
      },
      (r) {
        emit(const HomePageState.loading());
        emit(const HomePageState.loginSuccess());
      },
    );
  }
}
