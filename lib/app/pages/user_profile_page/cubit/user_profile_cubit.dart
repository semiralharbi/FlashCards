import 'package:injectable/injectable.dart';

import '../../../../domain/entities/user/user_profile_entity.dart';
import '../../../../domain/use_case/delete_account_use_case.dart';
import '../../../../domain/use_case/get_user_profile_use_case.dart';
import '../../../../domain/use_case/reset_password_use_case.dart';
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
    this._resetPasswordUseCase,
  ) : super(UserProfileState.loaded());

  final GetUserProfileUseCase _getUserProfileUseCase;
  final UpdateUserProfileUseCase _updateUserProfileUseCase;
  final SingOutUseCase _singOutUseCase;
  final DeleteAccountUseCase _deleteAccountUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;

  Future<void> getUserProfile() async {
    final userProfile = await _getUserProfileUseCase();
    userProfile.fold(
      (l) => emit(const UserProfileState.fail(error: Errors.unknownError)),
      (r) => emit(UserProfileState.loaded(userProfile: r)),
    );
  }

  Future<void> onUpdateUserProfileButton({
    String? username,
    String? nativeLanguage,
    String? appLanguage,
    String? languageToLearn,
  }) async {
    await _updateUserProfileUseCase(
      UserProfileEntity(
        name: username,
        nativeLanguage: nativeLanguage,
        appLanguage: appLanguage,
        languageToLearn: languageToLearn,
      ),
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

  Future<void> onResetPassword(String email) async {
    final result = await _resetPasswordUseCase(email);
    result.fold(
      (l) {
        emit(UserProfileState.loaded());

        emit(const UserProfileState.fail(error: Errors.wrongEmail));
      },
      (r) => emit(const UserProfileState.success()),
    );
  }
}
