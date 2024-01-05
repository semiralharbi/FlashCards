import 'package:injectable/injectable.dart';

import '../../../../domain/use_case/get_user_profile_use_case.dart';
import '../../../theme/global_imports.dart';
import '../../../utils/enums/errors.dart';
import 'user_profile_state.dart';

@injectable
class UserProfileCubit extends Cubit<UserProfileState> {
  UserProfileCubit(
    this.userCollection,
  ) : super(UserProfileState.loaded()) {
    init();
  }

  final GetUserProfileUseCase userCollection;

  Future<void> init() async {
    final userProfile = await userCollection.call();
    userProfile.fold(
      (l) => emit(const UserProfileState.fail(error: Errors.unknownError)),
      (r) => emit(
        UserProfileState.loaded(userProfile: r),
      ),
    );
  }

  Future<void> onUpdateButton(String username) async {
    emit(const UserProfileState.loading());
  }
}
