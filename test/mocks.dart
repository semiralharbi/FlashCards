import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_cards/app/pages/add_folder_words_page/cubit/add_folder_words_cubit.dart';
import 'package:flash_cards/app/pages/folder_content_page/cubit/folder_content_cubit.dart';
import 'package:flash_cards/app/pages/home_page/cubit/home_cubit.dart';
import 'package:flash_cards/app/pages/login_page/cubit/login_cubit.dart';
import 'package:flash_cards/app/pages/registration_page/cubit/registration_cubit.dart';
import 'package:flash_cards/app/pages/username_page/cubit/username_cubit.dart';
import 'package:flash_cards/domain/data_source/remote/authentication_remote_source.dart';
import 'package:flash_cards/domain/data_source/remote/database_remote_source.dart';
import 'package:flash_cards/domain/repositories/authentication_repo.dart';
import 'package:flash_cards/domain/repositories/database_repository.dart';
import 'package:flash_cards/domain/use_case/create_user_use_case.dart';
import 'package:flash_cards/domain/use_case/delete_folder_use_case.dart';
import 'package:flash_cards/domain/use_case/delete_word_use_case.dart';
import 'package:flash_cards/domain/use_case/get_currect_user_use_case.dart';
import 'package:flash_cards/domain/use_case/get_folders_use_case.dart';
import 'package:flash_cards/domain/use_case/login_use_case.dart';
import 'package:flash_cards/domain/use_case/new_data_folder_use_case.dart';
import 'package:flash_cards/domain/use_case/sign_out_use_case.dart';
import 'package:flash_cards/domain/use_case/update_user_profile_use_case.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([
  CreateFolderUseCase,
  GetCurrentUserUseCase,
  SingOutUseCase,
  DeleteFolderDataUseCase,
  GetFoldersUseCase,
  LoginUseCase,
  CreateUserUseCase,
  HomeCubit,
  LoginCubit,
  RegistrationCubit,
  UsernameCubit,
  FolderContentCubit,
  DeleteWordUseCase,
  DatabaseRemoteSource,
  DatabaseRepository,
  AuthenticationRepo,
  AuthenticationRemoteSource,
  UpdateUserProfileUseCase,
])
void main() {}

class MockAddFolderWordsCubit extends MockCubit<AddFolderWordsState> implements AddFolderWordsCubit {}

class MockFirebaseAuth extends Mock implements FirebaseAuth {
  MockFirebaseAuth({this.currentUser});

  @override
  final User? currentUser;
}

class MockUserCredential extends Mock implements UserCredential {
  MockUserCredential({this.user});

  @override
  final User? user;
}

class FakeUser extends Fake implements User {
  FakeUser({this.mockedDisplayName, this.mockedUid});

  final String? mockedDisplayName;
  final String? mockedUid;

  @override
  String get uid => mockedUid ?? 'mockedUid';

  @override
  String? get displayName => mockedDisplayName;
}
