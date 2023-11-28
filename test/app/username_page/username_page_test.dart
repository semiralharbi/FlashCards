import 'package:flash_cards/app/pages/username_page/cubit/username_state.dart';
import 'package:flash_cards/app/pages/username_page/username_page.dart';
import 'package:flash_cards/app/utils/enums/errors.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../golden_test_runner.dart';
import '../../mocks.mocks.dart';

void main() {
  late MockUsernameCubit mockUsernameCubit;

  setUp(() => mockUsernameCubit = MockUsernameCubit());

  runGoldenTest(
    'UsernamePage - Loaded',
    builder: () {
      when(mockUsernameCubit.state).thenAnswer((_) => const UsernameState.loaded());
      when(mockUsernameCubit.stream).thenAnswer((_) => Stream.value(const UsernameState.loaded()));

      return UsernamePage(cubit: mockUsernameCubit);
    },
  );

  runGoldenTest(
    'UsernamePage - Loaded with data',
    builder: () {
      when(mockUsernameCubit.state).thenAnswer((_) => const UsernameState.loaded(username: 'example'));
      when(mockUsernameCubit.stream).thenAnswer(
        (_) => Stream.value(
          const UsernameState.loaded(username: 'example'),
        ),
      );

      return UsernamePage(cubit: mockUsernameCubit);
    },
  );

  runGoldenTest(
    'UsernamePage - Failure',
    builder: () {
      when(mockUsernameCubit.state).thenAnswer((_) => const UsernameState.fail(error: Errors.somethingWentWrong));
      when(mockUsernameCubit.stream).thenAnswer(
        (_) => Stream.fromIterable(
          const [
            UsernameState.fail(error: Errors.somethingWentWrong),
            UsernameState.loaded(),
          ],
        ),
      );

      return UsernamePage(cubit: mockUsernameCubit);
    },
  );

  runGoldenTest(
    'UsernamePage - Validation',
    builder: () {
      when(mockUsernameCubit.state).thenAnswer((_) => const UsernameState.fail(error: Errors.somethingWentWrong));
      when(mockUsernameCubit.stream).thenAnswer(
        (_) => Stream.value(const UsernameState.loaded(usernameError: Errors.fieldCantBeEmpty)),
      );

      return UsernamePage(cubit: mockUsernameCubit);
    },
  );
}
