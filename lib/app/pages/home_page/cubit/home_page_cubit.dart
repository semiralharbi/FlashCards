import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import 'home_page_state.dart';

@injectable
class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit() : super(const HomePageState.initial());

  void onEmailRegisterClick({
    String? email,
    String? username,
    required bool loginAnimationValue,
    required bool registrationAnimationValue,
  }) {
    emit(HomePageState.passwordRegistration(
      registrationAnimationValue: registrationAnimationValue,
      loginAnimationValue: loginAnimationValue,
      email: email,
      username: username,
    ));
  }

  void onPasswordRegisterClick() {}
}
