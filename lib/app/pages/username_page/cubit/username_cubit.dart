import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/entities/update_user_entity.dart';
import '../../../../domain/use_case/update_user_use_case.dart';
import '../../../utils/enums/errors.dart';
import 'username_state.dart';

@injectable
class UsernameCubit extends Cubit<UsernameState> {
  UsernameCubit(this._updateUserUseCase) : super(const UsernameState.loaded());

  final UpdateUserUseCase _updateUserUseCase;

  Future<void> onUpdateButton(String username) async {
    emit(const UsernameState.loading());
    if (username.isNotEmpty) {
      final result = await _updateUserUseCase(UpdateUserEntity(username: username));
      result.fold(
        (l) {
          emit(UsernameState.fail(error: l.error));
          emit(UsernameState.loaded(username: username));
        },
        (r) => emit(const UsernameState.success()),
      );
    } else {
      emit(const UsernameState.loaded(usernameError: Errors.fieldCantBeEmpty));
    }
  }
}
