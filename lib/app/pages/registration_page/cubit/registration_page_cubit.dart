import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import 'registration_page_state.dart';

@injectable
class RegistrationPageCubit extends Cubit<RegistrationPageState> {
  RegistrationPageCubit() : super(const RegistrationPageState.initial());

  void onEmailRegisterClick({
    String? email,
    String? username,
  }) {
    emit(RegistrationPageState.userRegistration(
      email: email,
      username: username,
    ));
  }

  void onGoToLoginClick(){
    emit(const RegistrationPageState.initial());
  }

  void onRegisterClick() {
    emit(const RegistrationPageState.registerSuccess());
  }
}
