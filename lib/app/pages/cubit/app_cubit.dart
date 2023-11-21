import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'app_state.dart';

@injectable
class AppCubit extends Cubit<AppState> {
  AppCubit() : super(const AppState.initial());

  final user = FirebaseAuth.instance.currentUser;

  Future<void> checkUser() async {
    if (user != null) {
      final name = user?.displayName;
      if (name != null) {
        emit(const AppState.toHomePage());
      } else {
        emit(const AppState.toUsernamePage());
      }
    }
  }
}
