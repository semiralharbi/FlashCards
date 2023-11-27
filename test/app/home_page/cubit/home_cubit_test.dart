import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flash_cards/app/pages/home_page/cubit/home_cubit.dart';
import 'package:flash_cards/app/pages/home_page/cubit/home_state.dart';
import 'package:flash_cards/app/utils/enums/errors.dart';
import 'package:flash_cards/domain/utils/failure.dart';
import 'package:flash_cards/domain/utils/success.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../mocked_data.dart';
import '../../../mocks.mocks.dart';

void main() {
  late MockSingOutUseCase mockSingOutUseCase;
  late MockGetFoldersUseCase mockGetFoldersUseCase;
  late MockDeleteFolderDataUseCase mockDeleteFolderDataUseCase;

  setUp(() {
    mockSingOutUseCase = MockSingOutUseCase();
    mockGetFoldersUseCase = MockGetFoldersUseCase();
    mockDeleteFolderDataUseCase = MockDeleteFolderDataUseCase();
  });

  HomeCubit createCubit() => HomeCubit(
        mockGetFoldersUseCase,
        mockDeleteFolderDataUseCase,
        mockSingOutUseCase,
      );

  blocTest<HomeCubit, HomeState>(
    'HomeCubit test - Fetch folders successful',
    setUp: () {
      when(mockGetFoldersUseCase()).thenAnswer((_) async => const Right(mockedFoldersList));
    },
    build: createCubit,
    act: (bloc) => bloc.fetchFolders(),
    expect: () => [
      const HomeState.loaded(folders: mockedFoldersList),
    ],
    verify: (_) {
      verify(mockGetFoldersUseCase());
      verifyNoMoreInteractions(mockGetFoldersUseCase);
      verifyZeroInteractions(mockDeleteFolderDataUseCase);
      verifyZeroInteractions(mockSingOutUseCase);
    },
  );

  blocTest<HomeCubit, HomeState>(
    'HomeCubit test - Fetch folders failure',
    setUp: () {
      when(mockGetFoldersUseCase()).thenAnswer((_) async => const Left(Failure(error: Errors.somethingWentWrong)));
    },
    build: createCubit,
    act: (bloc) => bloc.fetchFolders(),
    expect: () => [
      const HomeState.empty(failure: Errors.somethingWentWrong),
    ],
    verify: (_) {
      verify(mockGetFoldersUseCase());
      verifyNoMoreInteractions(mockGetFoldersUseCase);
      verifyZeroInteractions(mockDeleteFolderDataUseCase);
      verifyZeroInteractions(mockSingOutUseCase);
    },
  );

  blocTest<HomeCubit, HomeState>(
    'HomeCubit test - Delete folder successful',
    setUp: () {
      when(mockDeleteFolderDataUseCase(any)).thenAnswer((_) async => const Right(Success()));
      when(mockGetFoldersUseCase()).thenAnswer((_) async => const Right(mockedFoldersList));
    },
    build: createCubit,
    act: (bloc) => bloc.deleteFolder(mockedFolderEntityV1),
    expect: () => [const HomeState.loaded(folders: mockedFoldersList)],
    verify: (_) {
      verify(mockDeleteFolderDataUseCase(any));
      verify(mockGetFoldersUseCase());
      verifyNoMoreInteractions(mockDeleteFolderDataUseCase);
      verifyNoMoreInteractions(mockGetFoldersUseCase);
      verifyZeroInteractions(mockSingOutUseCase);
    },
  );

  blocTest<HomeCubit, HomeState>(
    'HomeCubit test - Delete folder failure',
    setUp: () {
      when(mockDeleteFolderDataUseCase(any))
          .thenAnswer((_) async => const Left(Failure(error: Errors.somethingWentWrong)));
    },
    build: createCubit,
    act: (bloc) => bloc.deleteFolder(mockedFolderEntityV1),
    expect: () => [const HomeState.fail(Errors.somethingWentWrong)],
    verify: (_) {
      verify(mockDeleteFolderDataUseCase(any));
      verifyNoMoreInteractions(mockDeleteFolderDataUseCase);
      verifyZeroInteractions(mockGetFoldersUseCase);
      verifyZeroInteractions(mockSingOutUseCase);
    },
  );

  blocTest<HomeCubit, HomeState>(
    'HomeCubit test - Sing out successful',
    setUp: () {
      when(mockSingOutUseCase()).thenAnswer((_) async => const Right(Success()));
    },
    build: createCubit,
    act: (bloc) => bloc.logout(),
    expect: () => [const HomeState.logout()],
    verify: (_) {
      verify(mockSingOutUseCase());
      verifyNoMoreInteractions(mockSingOutUseCase);
      verifyZeroInteractions(mockDeleteFolderDataUseCase);
      verifyZeroInteractions(mockGetFoldersUseCase);
    },
  );

  blocTest<HomeCubit, HomeState>(
    'HomeCubit test - Sing out failure',
    setUp: () {
      when(mockSingOutUseCase()).thenAnswer((_) async => const Left(Failure(error: Errors.somethingWentWrong)));
    },
    build: createCubit,
    act: (bloc) => bloc.logout(),
    expect: () => [const HomeState.fail(Errors.somethingWentWrong)],
    verify: (_) {
      verify(mockSingOutUseCase());
      verifyNoMoreInteractions(mockSingOutUseCase);
      verifyZeroInteractions(mockDeleteFolderDataUseCase);
      verifyZeroInteractions(mockGetFoldersUseCase);
    },
  );
}
