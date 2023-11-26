import 'package:bloc_test/bloc_test.dart';
import 'package:flash_cards/app/pages/add_folder_words_page/add_folder_words_page.dart';
import 'package:flash_cards/app/pages/add_folder_words_page/cubit/add_folder_words_cubit.dart';
import 'package:flash_cards/app/theme/global_imports.dart';
import 'package:flash_cards/app/widgets/textfield_widget.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../golden_test_runner.dart';
import '../../mocked_data.dart';
import '../../mocks.dart';

void main() {
  late MockAddFolderWordsCubit mockAddFolderWordsCubit;
  late Widget testedPage;

  setUp(() {
    mockAddFolderWordsCubit = MockAddFolderWordsCubit();
    testedPage = AddFolderWordsPage(
      folderName: 'folderName',
      cubit: mockAddFolderWordsCubit,
    );
  });

  runGoldenTest(
    'AddFolderWordsPage - Initial',
    builder: () {
      whenListen(
        mockAddFolderWordsCubit,
        Stream.fromIterable(
          const [
            AddFolderWordsState.loaded([]),
          ],
        ),
        initialState: const AddFolderWordsState.loaded([]),
      );
      return testedPage;
    },
  );

  runGoldenTest(
    'AddFolderWordsPage - Loaded',
    builder: () {
      whenListen(
        mockAddFolderWordsCubit,
        Stream.fromIterable(
          const [
            AddFolderWordsState.loaded([mockedWordEntity]),
          ],
        ),
        initialState: const AddFolderWordsState.loaded([]),
      );
      return testedPage;
    },
    whilePerforming: (tester) async {
      final textFieldWidget = find.byType(TextFieldWidget);

      expect(textFieldWidget, findsOneWidget);

      await tester.enterText(textFieldWidget.first, 'my initial word');
      await tester.pumpAndSettle();


      expect(textFieldWidget, findsNWidgets(2));

      await tester.enterText(textFieldWidget.last, 'my translated word');
      await tester.pumpAndSettle();

      final textButtons = find.byType(TextButton);

      expect(textButtons, findsNWidgets(2));
      return;
    },
  );
}
