import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'app_state.dart';

@injectable
class AppCubit extends Cubit<AppState> {
  AppCubit() : super(const AppState.initial()) {
    checkUser();
  }

  Future<void> checkUser() async {
    // ignore: await_only_futures
    final user = await FirebaseAuth.instance.currentUser;
    if (user != null) {
      final name = FirebaseAuth.instance.currentUser!.displayName;
      if (name != null) {
        emit(const AppState.toHomePage());
      } else {
        emit(const AppState.toUsernamePage());
      }
    }
  }
}
