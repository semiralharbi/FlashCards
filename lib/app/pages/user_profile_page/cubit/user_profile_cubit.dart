import 'package:injectable/injectable.dart';

import '../../../theme/global_imports.dart';
import 'user_profile_state.dart';

@injectable
class UserProfileCubit extends Cubit<UserProfileState> {
  UserProfileCubit() : super(const UserProfileState.loaded());

  // final UpdateUserProfileUseCase _updateUserProfileUseCase;

  Future<void> onUpdateButton(String username) async {
    emit(const UserProfileState.loading());
    emit(UserProfileState.loaded(username: username));
  }
}
