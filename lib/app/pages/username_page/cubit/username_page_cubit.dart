import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/entities/update_user_entity.dart';
import '../../../../domain/use_case/update_user_use_case.dart';
import 'username_page_state.dart';

@injectable
class UsernamePageCubit extends Cubit<UsernamePageState> {
  UsernamePageCubit(this._updateUserUseCase)
      : super(const UsernamePageState.initial());

  final UpdateUserUseCase _updateUserUseCase;

  Future<void> onUpdateButton(String username) async {
    final result = await _updateUserUseCase(
      UpdateUserEntity(username: username),
    );
    result.fold(
      (l) {
        emit(UsernamePageState.fail(error: l.appError));
        emit(UsernamePageState.initial(username: username));
      },
      (r) {
        emit(const UsernamePageState.loading());
        emit(const UsernamePageState.success());
      },
    );
  }
}
