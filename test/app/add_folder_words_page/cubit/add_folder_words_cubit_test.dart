import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flash_cards/app/pages/add_folder_words_page/cubit/add_folder_words_cubit.dart';

import 'package:flash_cards/domain/utils/success.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../mocked_data.dart';
import '../../../mocks.mocks.dart';

void main() {
  late MockCreateFolderUseCase mockCreateFolderUseCase;

  setUpAll(() {
    mockCreateFolderUseCase = MockCreateFolderUseCase();
  });

  AddFolderWordsCubit createCubit() => AddFolderWordsCubit(mockCreateFolderUseCase);

  blocTest<AddFolderWordsCubit, AddFolderWordsState>(
    'Add word to cache and emit loaded',
    build: createCubit,
    act: (bloc) => bloc.addWord(mockedWordEntity),
    expect: () => <AddFolderWordsState>[
      const AddFolderWordsState.loading(),
      const AddFolderWordsState.loaded([mockedWordEntity]),
    ],
    verify: (bloc) {
      verifyZeroInteractions(mockCreateFolderUseCase);
      expect(bloc.wordsList, contains(mockedWordEntity));
    },
  );

  blocTest<AddFolderWordsCubit, AddFolderWordsState>(
    'createFolder by sending data to use case and emit success',
    build: createCubit,
    setUp: () => when(mockCreateFolderUseCase(any)).thenAnswer((_) async => const Right(Success())),
    act: (bloc) => bloc.createFolder(folderName: 'a'),
    expect: () => <AddFolderWordsState>[
      const AddFolderWordsState.loading(),
      const AddFolderWordsState.success(),
    ],
    verify: (bloc) {
      verify(mockCreateFolderUseCase(any));
      verifyNoMoreInteractions(mockCreateFolderUseCase);
    },
  );
}
