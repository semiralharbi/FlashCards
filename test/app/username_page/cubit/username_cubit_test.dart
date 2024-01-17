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
  late MockUpdateUserProfileUseCase mockUpdateUserProfileUseCase;
  setUp(() => mockUpdateUserProfileUseCase = MockUpdateUserProfileUseCase());

  UsernameCubit createCubit() => UsernameCubit(mockUpdateUserProfileUseCase);
  blocTest(
    'UsernameCubit - Update Username Success',
    setUp: () => when(mockUpdateUserProfileUseCase(any)).thenAnswer((_) async => const Right(Success())),
    build: createCubit,
    act: (cubit) => cubit.onUpdateButton(mockedUsername),
    verify: (_) {
      verify(mockUpdateUserProfileUseCase(any));
      verifyNoMoreInteractions(mockUpdateUserProfileUseCase);
    },
    expect: () => [
      const UsernameState.loading(),
      const UsernameState.success(),
    ],
  );

  blocTest(
    'UsernameCubit - Failure then Loaded with data',
    setUp: () => when(mockUpdateUserProfileUseCase(any)).thenAnswer(
      (_) async => const Left(
        Failure(error: Errors.somethingWentWrong),
      ),
    ),
    build: createCubit,
    act: (cubit) => cubit.onUpdateButton(mockedUsername),
    verify: (_) {
      verify(mockUpdateUserProfileUseCase(any));
      verifyNoMoreInteractions(mockUpdateUserProfileUseCase);
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
    verify: (_) => verifyZeroInteractions(mockUpdateUserProfileUseCase),
    expect: () => [
      const UsernameState.loading(),
      const UsernameState.loaded(usernameError: Errors.fieldCantBeEmpty),
    ],
  );
}
