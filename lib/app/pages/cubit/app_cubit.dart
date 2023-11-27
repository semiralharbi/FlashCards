import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/use_case/get_currect_user_use_case.dart';
import 'app_state.dart';

@injectable
class AppCubit extends Cubit<AppState> {
  AppCubit(this._getCurrentUserUseCase) : super(const AppState.initial());

  final GetCurrentUserUseCase _getCurrentUserUseCase;

  Future<void> checkUser() async {
    final result = await _getCurrentUserUseCase();
    result.fold(
      (_) => _,
      (user) {
        final name = user.displayName;
        if (name != null && name.isNotEmpty) {
          emit(const AppState.toHomePage());
        } else {
          emit(const AppState.toUsernamePage());
        }
      },
    );
  }
}
