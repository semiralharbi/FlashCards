import 'package:injectable/injectable.dart';

import '../../../../domain/entities/user/user_profile_entity.dart';
import '../../../../domain/use_case/delete_account_use_case.dart';
import '../../../../domain/use_case/get_user_profile_use_case.dart';
import '../../../../domain/use_case/sign_out_use_case.dart';
import '../../../../domain/use_case/update_user_profile_use_case.dart';
import '../../../theme/global_imports.dart';
import '../../../utils/enums/errors.dart';
import 'user_profile_state.dart';

@injectable
class UserProfileCubit extends Cubit<UserProfileState> {
  UserProfileCubit(
    this._getUserProfileUseCase,
    this._updateUserProfileUseCase,
    this._singOutUseCase,
    this._deleteAccountUseCase,
  ) : super(UserProfileState.loaded());

  final GetUserProfileUseCase _getUserProfileUseCase;
  final UpdateUserProfileUseCase _updateUserProfileUseCase;
  final SingOutUseCase _singOutUseCase;
  final DeleteAccountUseCase _deleteAccountUseCase;

  Future<void> init() async {
    final userProfile = await _getUserProfileUseCase();
    userProfile.fold(
      (l) => emit(const UserProfileState.fail(error: Errors.unknownError)),
      (r) => emit(UserProfileState.loaded(userProfile: r)),
    );
  }

  Future<void> onUpdateNameButton(String username) async {
    await _updateUserProfileUseCase(
      UserProfileEntity(name: username, userId: '', initialLanguage: '', userFolders: [], email: ''),
    );
    final userProfile = await _getUserProfileUseCase();
    userProfile.fold(
      (l) => emit(const UserProfileState.fail(error: Errors.unknownError)),
      (r) {
        emit(const UserProfileState.loading());
        emit(UserProfileState.loaded(userProfile: r));
      },
    );
  }

  Future<void> onSignOutButton() async {
    final result = await _singOutUseCase();
    result.fold(
      (l) => emit(const UserProfileState.fail(error: Errors.unknownError)),
      (r) => emit(const UserProfileState.success()),
    );
  }

  Future<void> onDeleteAccount() async {
    final result = await _deleteAccountUseCase();
    result.fold(
      (l) => emit(const UserProfileState.fail(error: Errors.unknownError)),
      (r) => emit(const UserProfileState.success()),
    );
  }
}
