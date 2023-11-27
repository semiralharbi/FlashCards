import 'package:flash_cards/app/pages/registration_page/cubit/registration_state.dart';
import 'package:flash_cards/app/pages/registration_page/registration_page.dart';
import 'package:flash_cards/app/utils/enums/errors.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../golden_test_runner.dart';
import '../../mocked_data.dart';
import '../../mocks.mocks.dart';

void main() {
  late MockRegistrationCubit mockedCubit;

  setUp(() {
    mockedCubit = MockRegistrationCubit();
  });

  runGoldenTest(
    'RegistrationPage - Loaded',
    builder: () {
      when(mockedCubit.state).thenAnswer((_) => const RegistrationState.loaded());
      when(mockedCubit.stream).thenAnswer((_) => Stream.value(const RegistrationState.loaded()));

      return RegistrationPage(cubit: mockedCubit);
    },
  );

  runGoldenTest(
    'RegistrationPage - Loaded With Data',
    builder: () {
      when(mockedCubit.state).thenAnswer(
        (_) => const RegistrationState.loaded(
          email: mockedEmail,
          password: mockedPassword,
          repeatPassword: mockedPassword,
        ),
      );
      when(mockedCubit.stream).thenAnswer(
        (_) => Stream.value(
          const RegistrationState.loaded(
            email: mockedEmail,
            password: mockedPassword,
            repeatPassword: mockedPassword,
          ),
        ),
      );

      return RegistrationPage(cubit: mockedCubit);
    },
  );

  runGoldenTest(
    'RegistrationPage - Validation',
    builder: () {
      when(mockedCubit.state).thenAnswer((_) => const RegistrationState.loaded());
      when(mockedCubit.stream).thenAnswer(
        (_) => Stream.value(
          const RegistrationState.loaded(
            emailError: Errors.fieldCantBeEmpty,
            passwordError: Errors.passwordMatch,
            repeatPasswordError: Errors.passwordMatch,
          ),
        ),
      );

      return RegistrationPage(cubit: mockedCubit);
    },
  );
}
