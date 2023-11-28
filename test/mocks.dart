import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_cards/app/pages/add_folder_words_page/cubit/add_folder_words_cubit.dart';
import 'package:flash_cards/app/pages/home_page/cubit/home_cubit.dart';
import 'package:flash_cards/app/pages/login_page/cubit/login_cubit.dart';
import 'package:flash_cards/app/pages/registration_page/cubit/registration_cubit.dart';
import 'package:flash_cards/app/pages/username_page/cubit/username_cubit.dart';
import 'package:flash_cards/domain/use_case/create_user_use_case.dart';
import 'package:flash_cards/domain/use_case/delete_folder_use_case.dart';
import 'package:flash_cards/domain/use_case/get_currect_user_use_case.dart';
import 'package:flash_cards/domain/use_case/get_folders_use_case.dart';
import 'package:flash_cards/domain/use_case/login_use_case.dart';
import 'package:flash_cards/domain/use_case/new_data_folder_use_case.dart';
import 'package:flash_cards/domain/use_case/sign_out_use_case.dart';
import 'package:flash_cards/domain/use_case/update_user_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  CreateFolderUseCase,
  GetCurrentUserUseCase,
  SingOutUseCase,
  DeleteFolderDataUseCase,
  GetFoldersUseCase,
  LoginUseCase,
  CreateUserUseCase,
  UpdateUserUseCase,
  HomeCubit,
  LoginCubit,
  RegistrationCubit,
  UsernameCubit,
])
void main() {}

class MockAddFolderWordsCubit extends MockCubit<AddFolderWordsState> implements AddFolderWordsCubit {}

class FakeUser extends Fake implements User {
  FakeUser({this.mockedDisplayName});

  final String? mockedDisplayName;

  @override
  String? get displayName => mockedDisplayName;
}
