import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flash_cards/app/pages/login_page/cubit/login_cubit.dart';
import 'package:flash_cards/app/pages/login_page/cubit/login_state.dart';
import 'package:flash_cards/app/utils/enums/errors.dart';
import 'package:flash_cards/domain/utils/failure.dart';
import 'package:flash_cards/domain/utils/success.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../mocked_data.dart';
import '../../../mocks.mocks.dart';

void main() {
  late MockLoginUseCase mockLoginUseCase;
  late MockGetUserProfileUseCase mockGetUserProfileUseCase;

  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
    mockGetUserProfileUseCase = MockGetUserProfileUseCase();
  });

  LoginCubit createCubit() => LoginCubit(mockLoginUseCase, mockGetUserProfileUseCase);

  blocTest<LoginCubit, LoginState>(
    'LoginCubit - onLoginButton when UserEntity has no username',
    setUp: () {
      when(mockLoginUseCase(any)).thenAnswer((_) async => const Right(Success()));
      when(mockGetUserProfileUseCase()).thenAnswer((_) async => const Right(mockedUserProfileEntityWithoutUsername));
    },
    build: createCubit,
    act: (cubit) => cubit.onLoginButton(mockedEmail, mockedPassword),
    verify: (cubit) {
      verify(mockLoginUseCase(any));
      verify(mockGetUserProfileUseCase());
      verifyNoMoreInteractions(mockLoginUseCase);
      verifyNoMoreInteractions(mockGetUserProfileUseCase);
    },
    expect: () => const [
      LoginState.loading(),
      LoginState.showUsernamePage(),
    ],
  );

  blocTest<LoginCubit, LoginState>(
    'LoginCubit - onLoginButton when UserEntity has username',
    setUp: () {
      when(mockLoginUseCase(any)).thenAnswer((_) async => const Right(Success()));
      when(mockGetUserProfileUseCase()).thenAnswer((_) async => const Right(mockedUserProfileEntity));
    },
    build: createCubit,
    act: (cubit) => cubit.onLoginButton(mockedEmail, mockedPassword),
    verify: (cubit) {
      verify(mockLoginUseCase(any));
      verifyNoMoreInteractions(mockLoginUseCase);
    },
    expect: () => const [
      LoginState.loading(),
      LoginState.showHomePage(),
    ],
  );

  blocTest<LoginCubit, LoginState>(
    'LoginCubit - onLoginButton failure with data',
    setUp: () {
      when(mockLoginUseCase(any)).thenAnswer((_) async => const Left(Failure(error: Errors.wrongPassword)));
    },
    build: createCubit,
    act: (cubit) => cubit.onLoginButton(mockedEmail, mockedPassword),
    verify: (cubit) {
      verify(mockLoginUseCase(any));
      verifyNoMoreInteractions(mockLoginUseCase);
      verifyNoMoreInteractions(mockGetUserProfileUseCase);
    },
    expect: () => const [
      LoginState.loading(),
      LoginState.fail(error: Errors.wrongPassword),
      LoginState.loaded(email: mockedEmail, password: mockedPassword),
    ],
  );

  blocTest<LoginCubit, LoginState>(
    'LoginCubit - onLoginButton failure with data',
    setUp: () {
      when(mockLoginUseCase(any)).thenAnswer((_) async => const Right(Success()));
      when(mockGetUserProfileUseCase()).thenAnswer((_) async => const Left(Failure(error: Errors.somethingWentWrong)));
    },
    build: createCubit,
    act: (cubit) => cubit.onLoginButton(mockedEmail, mockedPassword),
    verify: (cubit) {
      verify(mockLoginUseCase(any));
      verify(mockGetUserProfileUseCase());
      verifyNoMoreInteractions(mockLoginUseCase);
      verifyNoMoreInteractions(mockGetUserProfileUseCase);
    },
    expect: () => const [
      LoginState.loading(),
      LoginState.fail(error: Errors.somethingWentWrong),
      LoginState.loaded(email: mockedEmail, password: mockedPassword),
    ],
  );
}
