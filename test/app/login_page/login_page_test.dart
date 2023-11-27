import 'package:flash_cards/app/pages/login_page/cubit/login_state.dart';
import 'package:flash_cards/app/pages/login_page/login_page.dart';
import 'package:flash_cards/app/utils/enums/errors.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../golden_test_runner.dart';
import '../../mocked_data.dart';
import '../../mocks.mocks.dart';

void main() {
  late MockLoginCubit mockLoginCubit;

  setUp(() {
    mockLoginCubit = MockLoginCubit();
  });

  runGoldenTest(
    'LoginPage - Loaded',
    builder: () {
      when(mockLoginCubit.state).thenAnswer((realInvocation) => const LoginState.loading());
      when(mockLoginCubit.stream).thenAnswer((realInvocation) => Stream.value(const LoginState.loaded()));

      return LoginPage(cubit: mockLoginCubit);
    },
  );

  runGoldenTest(
    'LoginPage - Loaded With Data',
    builder: () {
      when(mockLoginCubit.state).thenAnswer((realInvocation) => const LoginState.loading());
      when(mockLoginCubit.stream).thenAnswer(
        (realInvocation) => Stream.value(
          const LoginState.loaded(
            email: mockedEmail,
            password: mockedPassword,
          ),
        ),
      );

      return LoginPage(cubit: mockLoginCubit);
    },
  );

  runGoldenTest(
    'LoginPage - Failure',
    builder: () {
      when(mockLoginCubit.state).thenAnswer((realInvocation) => const LoginState.loading());
      when(mockLoginCubit.stream).thenAnswer(
        (realInvocation) => Stream.value(const LoginState.fail(error: Errors.wrongPassword)),
      );

      return LoginPage(cubit: mockLoginCubit);
    },
  );
}
