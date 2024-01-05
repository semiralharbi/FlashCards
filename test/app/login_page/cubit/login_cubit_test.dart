import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flash_cards/app/pages/login_page/cubit/login_cubit.dart';
import 'package:flash_cards/app/pages/login_page/cubit/login_state.dart';
import 'package:flash_cards/app/utils/enums/errors.dart';
import 'package:flash_cards/domain/utils/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../mocked_data.dart';
import '../../../mocks.dart';
import '../../../mocks.mocks.dart';

void main() {
  late MockLoginUseCase mockLoginUseCase;

  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
  });

  LoginCubit createCubit() => LoginCubit(mockLoginUseCase);

  blocTest<LoginCubit, LoginState>(
    'LoginCubit - onLoginButton with empty user display name',
    setUp: () {
      when(mockLoginUseCase(any)).thenAnswer((_) async => Right(FakeUser(mockedDisplayName: '', mockedUid: "userId")));
    },
    build: createCubit,
    act: (cubit) => cubit.onLoginButton(mockedEmail, mockedPassword),
    verify: (cubit) {
      verify(mockLoginUseCase(any));
      verifyNoMoreInteractions(mockLoginUseCase);
    },
    expect: () => const [
      LoginState.loading(),
      LoginState.showUsernamePage(),
    ],
  );

  blocTest<LoginCubit, LoginState>(
    'LoginCubit - onLoginButton with user display name',
    setUp: () {
      when(mockLoginUseCase(any))
          .thenAnswer((_) async => Right(FakeUser(mockedDisplayName: 'name', mockedUid: "userId")));
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
    },
    expect: () => const [
      LoginState.loading(),
      LoginState.fail(error: Errors.wrongPassword),
      LoginState.loaded(email: mockedEmail, password: mockedPassword),
    ],
  );
}
