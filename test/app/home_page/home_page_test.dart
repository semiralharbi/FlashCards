import 'package:flash_cards/app/pages/home_page/cubit/home_state.dart';
import 'package:flash_cards/app/pages/home_page/home_page.dart';
import 'package:flash_cards/app/utils/enums/errors.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../golden_test_runner.dart';
import '../../mocked_data.dart';
import '../../mocks.mocks.dart';

void main() {
  late MockHomeCubit mockHomeCubit;

  setUp(() {
    mockHomeCubit = MockHomeCubit();
  });

  runGoldenTest(
    'HomePage - Loaded',
    builder: () {
      when(mockHomeCubit.state).thenAnswer((_) => const HomeState.loaded(folders: mockedFoldersList));
      when(mockHomeCubit.stream).thenAnswer((_) => Stream.value(const HomeState.loaded(folders: mockedFoldersList)));
      when(mockHomeCubit.fetchFolders()).thenAnswer((_) async {});

      return HomePage(cubit: mockHomeCubit);
    },
  );

  runGoldenTest(
    'HomePage - Empty',
    builder: () {
      when(mockHomeCubit.state).thenAnswer((_) => const HomeState.loading());
      when(mockHomeCubit.stream).thenAnswer(
        (_) => Stream.value(
          const HomeState.empty(failure: Errors.lackOfFolderDescription),
        ),
      );
      when(mockHomeCubit.fetchFolders()).thenAnswer((_) async {});

      return HomePage(cubit: mockHomeCubit);
    },
  );
}
