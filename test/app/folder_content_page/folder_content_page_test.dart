import 'package:flash_cards/app/pages/folder_content_page/cubit/folder_content_state.dart';
import 'package:flash_cards/app/pages/folder_content_page/folder_content_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../golden_test_runner.dart';
import '../../mocked_data.dart';
import '../../mocks.mocks.dart';

void main() {
  late MockFolderContentCubit mockFolderContentCubit;

  setUp(() {
    mockFolderContentCubit = MockFolderContentCubit();
  });

  runGoldenTest(
    'FolderContentPage - Loaded',
    builder: () {
      when(mockFolderContentCubit.state).thenAnswer((_) => const FolderContentState.loaded(mockedFolderEntityV1));
      when(mockFolderContentCubit.stream)
          .thenAnswer((_) => Stream.value(const FolderContentState.loaded(mockedFolderEntityV1)));

      return FolderContentPage(
        cubit: mockFolderContentCubit,
        folder: mockedFolderEntityV1,
      );
    },
  );
}
