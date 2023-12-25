import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flash_cards/app/pages/folder_content_page/cubit/folder_content_cubit.dart';
import 'package:flash_cards/app/pages/folder_content_page/cubit/folder_content_state.dart';
import 'package:flash_cards/domain/utils/success.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../mocked_data.dart';
import '../../../mocks.mocks.dart';

void main() {
  late MockDeleteWordUseCase mockDeleteWordUseCase;
  late MockGetFoldersUseCase mockGetFoldersUseCase;

  setUp(() {
    mockDeleteWordUseCase = MockDeleteWordUseCase();
    mockGetFoldersUseCase = MockGetFoldersUseCase();
  });

  FolderContentCubit createCubit() => FolderContentCubit(mockDeleteWordUseCase, mockGetFoldersUseCase);

  blocTest(
    'init emits Loaded when successful',
    setUp: () {
      when(mockGetFoldersUseCase()).thenAnswer((_) async => const Right(mockedFoldersList));
    },
    act: (cubit) => cubit.init(mockedFolderEntityV1),
    build: createCubit,
    expect: () => [const FolderContentState.loaded(mockedFolderEntityV1)],
    verify: (_) {
      verify(mockGetFoldersUseCase());
      verifyNoMoreInteractions(mockGetFoldersUseCase);
      verifyZeroInteractions(mockDeleteWordUseCase);
    },
  );

  blocTest(
    'deleteWord emits Loaded through init when successful',
    setUp: () {
      when(mockDeleteWordUseCase(any)).thenAnswer((_) async => const Right(Success()));
      when(mockGetFoldersUseCase()).thenAnswer((_) async => const Right(mockedFoldersList));
    },
    act: (cubit) => cubit.deleteWord(mockedFolderEntityV1, 1),
    build: createCubit,
    expect: () => [const FolderContentState.loaded(mockedFolderEntityV1)],
    verify: (_) {
      verify(mockGetFoldersUseCase());
      verify(mockDeleteWordUseCase(any));
      verifyNoMoreInteractions(mockGetFoldersUseCase);
      verifyNoMoreInteractions(mockDeleteWordUseCase);
    },
  );
}
