import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flash_cards/app/pages/registration_page/cubit/registration_cubit.dart';
import 'package:flash_cards/app/pages/registration_page/cubit/registration_state.dart';
import 'package:flash_cards/app/utils/enums/errors.dart';
import 'package:flash_cards/domain/utils/failure.dart';
import 'package:flash_cards/domain/utils/success.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../mocked_data.dart';
import '../../../mocks.mocks.dart';

void main() {
  late MockCreateUserUseCase mockCreateUserUseCase;

  setUp(() {
    mockCreateUserUseCase = MockCreateUserUseCase();
  });

  RegistrationCubit createCubit() => RegistrationCubit(mockCreateUserUseCase);

  blocTest(
    'RegistrationCubit - onRegisterClick success',
    setUp: () {
      when(mockCreateUserUseCase(any)).thenAnswer((_) async => const Right(Success()));
    },
    build: createCubit,
    act: (cubit) => cubit.onRegisterClick(
      email: mockedEmail,
      password: mockedPassword,
      repeatPassword: mockedPassword,
    ),
    verify: (_) {
      verify(mockCreateUserUseCase(any));
      verifyNoMoreInteractions(mockCreateUserUseCase);
    },
    expect: () => const [RegistrationState.loading(), RegistrationState.success()],
  );

  blocTest(
    'RegistrationCubit - onRegisterClick failure',
    setUp: () {
      when(mockCreateUserUseCase(any)).thenAnswer((_) async => const Left(Failure(error: Errors.somethingWentWrong)));
    },
    build: createCubit,
    act: (cubit) => cubit.onRegisterClick(
      email: mockedEmail,
      password: mockedPassword,
      repeatPassword: mockedPassword,
    ),
    verify: (_) {
      verify(mockCreateUserUseCase(any));
      verifyNoMoreInteractions(mockCreateUserUseCase);
    },
    expect: () => const [
      RegistrationState.loading(),
      RegistrationState.fail(error: Errors.somethingWentWrong),
      RegistrationState.loaded(
        email: mockedEmail,
        password: mockedPassword,
        repeatPassword: mockedPassword,
      ),
    ],
  );

  blocTest(
    'RegistrationCubit - onRegisterClick failure password validation',
    build: createCubit,
    act: (cubit) => cubit.onRegisterClick(
      email: mockedEmail,
      password: mockedPassword,
      repeatPassword: mockedPasswordV2,
    ),
    verify: (_) => verifyZeroInteractions(mockCreateUserUseCase),
    expect: () => const [
      RegistrationState.loading(),
      RegistrationState.loaded(
        email: mockedEmail,
        password: mockedPassword,
        repeatPassword: mockedPasswordV2,
        passwordError: Errors.passwordMatch,
        repeatPasswordError: Errors.passwordMatch,
      ),
    ],
  );

  blocTest(
    'RegistrationCubit - onRegisterClick failure email validation',
    build: createCubit,
    act: (cubit) => cubit.onRegisterClick(
      email: '',
      password: mockedPassword,
      repeatPassword: mockedPassword,
    ),
    verify: (_) => verifyZeroInteractions(mockCreateUserUseCase),
    expect: () => const [
      RegistrationState.loading(),
      RegistrationState.loaded(
        email: '',
        password: mockedPassword,
        repeatPassword: mockedPassword,
        emailError: Errors.fieldCantBeEmpty,
      ),
    ],
  );

  blocTest(
    'RegistrationCubit - onRegisterClick failure empty password validation',
    build: createCubit,
    act: (cubit) => cubit.onRegisterClick(
      email: mockedEmail,
      password: '',
      repeatPassword: '',
    ),
    verify: (_) => verifyZeroInteractions(mockCreateUserUseCase),
    expect: () => const [
      RegistrationState.loading(),
      RegistrationState.loaded(
        email: mockedEmail,
        password: '',
        repeatPassword: '',
        passwordError: Errors.fieldCantBeEmpty,
        repeatPasswordError: Errors.fieldCantBeEmpty,
      ),
    ],
  );
}
