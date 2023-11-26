import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:flash_cards/app/pages/add_folder_words_page/cubit/add_folder_words_cubit.dart';
import 'package:flash_cards/domain/use_case/new_data_folder_use_case.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  CreateFolderUseCase,
  FirebaseAppPlatform,
])
void main() {}

class MockAddFolderWordsCubit extends MockCubit<AddFolderWordsState> implements AddFolderWordsCubit {}
