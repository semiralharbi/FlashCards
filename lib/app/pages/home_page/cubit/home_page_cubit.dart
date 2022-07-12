import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import 'home_page_state.dart';

@injectable
class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit() : super(const HomePageState.initial());

  void onEmailRegisterClick({
    String? email,
    String? username,
  }) {
    emit(HomePageState.passwordRegistration(
      email: email,
      username: username,
    ));
  }

  void onGoToLoginClick(){
    emit(const HomePageState.initial());
  }

  void onGoToRegisterClick(){
    emit(const HomePageState.register());
  }

  void onLoginClick() {
    emit(const HomePageState.loginSuccess());
  }
}
