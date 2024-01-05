import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flash_cards/app/pages/cubit/app_cubit.dart';
import 'package:flash_cards/app/pages/cubit/app_state.dart';
import 'package:flash_cards/app/utils/enums/errors.dart';
import 'package:flash_cards/domain/utils/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../mocks.dart';
import '../../mocks.mocks.dart';

void main() {
  late MockGetCurrentUserUseCase mockGetCurrentUserUseCase;

  setUp(() {
    mockGetCurrentUserUseCase = MockGetCurrentUserUseCase();
  });

  AppCubit createCubit() => AppCubit(mockGetCurrentUserUseCase);

  blocTest<AppCubit, AppState>(
    'AppCubit test - User name empty',
    setUp: () {
      when(mockGetCurrentUserUseCase()).thenAnswer(
        (_) async => Right(
          FakeUser(mockedDisplayName: null, mockedUid: "userId"),
        ),
      );
    },
    build: createCubit,
    act: (bloc) => bloc.checkUser(),
    expect: () => [const AppState.toUsernamePage()],
    verify: (_) {
      verify(mockGetCurrentUserUseCase());
      verifyNoMoreInteractions(mockGetCurrentUserUseCase);
    },
  );

  blocTest<AppCubit, AppState>(
    'AppCubit test - User name not empty',
    setUp: () {
      when(mockGetCurrentUserUseCase()).thenAnswer(
        (_) async => Right(
          FakeUser(mockedDisplayName: 'UserName', mockedUid: "userId"),
        ),
      );
    },
    build: createCubit,
    act: (bloc) => bloc.checkUser(),
    expect: () => [const AppState.toHomePage()],
    verify: (_) {
      verify(mockGetCurrentUserUseCase());
      verifyNoMoreInteractions(mockGetCurrentUserUseCase);
    },
  );

  blocTest<AppCubit, AppState>(
    'AppCubit test - Failure',
    setUp: () {
      when(mockGetCurrentUserUseCase()).thenAnswer((_) async => const Left(Failure(error: Errors.somethingWentWrong)));
    },
    build: createCubit,
    act: (bloc) => bloc.checkUser(),
    expect: () => [],
    verify: (_) {
      verify(mockGetCurrentUserUseCase());
      verifyNoMoreInteractions(mockGetCurrentUserUseCase);
    },
  );
}
