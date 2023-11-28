import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flash_cards/app/pages/username_page/cubit/username_cubit.dart';
import 'package:flash_cards/app/pages/username_page/cubit/username_state.dart';
import 'package:flash_cards/app/utils/enums/errors.dart';
import 'package:flash_cards/domain/utils/failure.dart';
import 'package:flash_cards/domain/utils/success.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../mocked_data.dart';
import '../../../mocks.mocks.dart';

void main() {
  late MockUpdateUserUseCase mockUpdateUserUseCase;
  setUp(() => mockUpdateUserUseCase = MockUpdateUserUseCase());

  UsernameCubit createCubit() => UsernameCubit(mockUpdateUserUseCase);
  blocTest(
    'UsernameCubit - Update Username Success',
    setUp: () => when(mockUpdateUserUseCase(any)).thenAnswer((_) async => const Right(Success())),
    build: createCubit,
    act: (cubit) => cubit.onUpdateButton(mockedUsername),
    verify: (_) {
      verify(mockUpdateUserUseCase(any));
      verifyNoMoreInteractions(mockUpdateUserUseCase);
    },
    expect: () => [
      const UsernameState.loading(),
      const UsernameState.success(),
    ],
  );

  blocTest(
    'UsernameCubit - Failure then Loaded with data',
    setUp: () => when(mockUpdateUserUseCase(any)).thenAnswer(
      (_) async => const Left(
        Failure(error: Errors.somethingWentWrong),
      ),
    ),
    build: createCubit,
    act: (cubit) => cubit.onUpdateButton(mockedUsername),
    verify: (_) {
      verify(mockUpdateUserUseCase(any));
      verifyNoMoreInteractions(mockUpdateUserUseCase);
    },
    expect: () => [
      const UsernameState.loading(),
      const UsernameState.fail(error: Errors.somethingWentWrong),
      const UsernameState.loaded(username: mockedUsername),
    ],
  );

  blocTest(
    'UsernameCubit - Validation error',
    build: createCubit,
    act: (cubit) => cubit.onUpdateButton(''),
    verify: (_) => verifyZeroInteractions(mockUpdateUserUseCase),
    expect: () => [
      const UsernameState.loading(),
      const UsernameState.loaded(usernameError: Errors.fieldCantBeEmpty),
    ],
  );
}
