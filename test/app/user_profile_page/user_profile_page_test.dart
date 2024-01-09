import 'package:flash_cards/app/pages/user_profile_page/cubit/user_profile_state.dart';
import 'package:flash_cards/app/pages/user_profile_page/user_profile_page.dart';
import 'package:flash_cards/app/utils/enums/errors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../golden_test_runner.dart';
import '../../mocked_data.dart';
import '../../mocks.mocks.dart';

void main() {
  late MockUserProfileCubit mockUserProfileCubit;

  setUp(() {
    mockUserProfileCubit = MockUserProfileCubit();
    when(mockUserProfileCubit.state).thenAnswer((_) => UserProfileState.loaded(userProfile: mockedUserProfileEntity));
    when(mockUserProfileCubit.stream)
        .thenAnswer((_) => Stream.value(UserProfileState.loaded(userProfile: mockedUserProfileEntity)));
    when(mockUserProfileCubit.close()).thenAnswer((_) async {});
  });

  runGoldenTest(
    'UserProfilePage - initial',
    builder: () {
      return UserProfilePage(cubit: mockUserProfileCubit);
    },
  );

  runGoldenTest(
    'UserProfilePage - edit',
    whilePerforming: (tester) async {
      final finder = find.byIcon(Icons.draw_outlined);
      await tester.tap(finder);
      await tester.pumpAndSettle();
      return null;
    },
    builder: () {
      return UserProfilePage(cubit: mockUserProfileCubit);
    },
  );

  runGoldenTest(
    'UserProfilePage - error',
    builder: () {
      when(mockUserProfileCubit.state).thenAnswer((_) => const UserProfileState.fail(error: Errors.somethingWentWrong));
      when(mockUserProfileCubit.stream)
          .thenAnswer((_) => Stream.value(const UserProfileState.fail(error: Errors.somethingWentWrong)));

      return UserProfilePage(cubit: mockUserProfileCubit);
    },
  );
}
