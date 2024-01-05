import 'package:flash_cards/app/pages/user_profile_page/cubit/user_profile_state.dart';
import 'package:flash_cards/app/pages/user_profile_page/user_profile_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../golden_test_runner.dart';
import '../../mocks.mocks.dart';

void main() {
  late MockUserProfileCubit mockUserProfileCubit;

  setUp(() {
    mockUserProfileCubit = MockUserProfileCubit();
    when(mockUserProfileCubit.state).thenAnswer((_) => UserProfileState.loaded());
    when(mockUserProfileCubit.stream).thenAnswer((_) => Stream.value(UserProfileState.loaded()));
    when(mockUserProfileCubit.close()).thenAnswer((_) async {});
  });
  runGoldenTest(
    'UserProfilePage - initial',
    builder: () {
      return UserProfilePage(cubit: mockUserProfileCubit);
    },
  );
}
