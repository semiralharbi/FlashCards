import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
        emit(
          AppState.toHomePage(
            name: name,
          ),
        );
      } else {
        emit(const AppState.toUsernamePage());
      }
    }
  }
}
