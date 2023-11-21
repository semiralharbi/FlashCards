import '../../theme/global_imports.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/custom_drawer/custom_drawer.dart';
import '../../widgets/textfield_widget.dart';

@RoutePage()
class AddFolderWordsPage extends StatefulWidget {
  const AddFolderWordsPage({super.key, required this.folderName});

  final String folderName;

  @override
  State<AddFolderWordsPage> createState() => _AddFolderWordsPageState();
}

class _AddFolderWordsPageState extends State<AddFolderWordsPage> {
  late TextEditingController _initialWordController;
  late TextEditingController _translatedWordController;
  late bool _isInitialWordNotEmpty = false;

  @override
  void initState() {
    _initialWordController = TextEditingController();
    _translatedWordController = TextEditingController();
    super.initState();
  }

  void _updateInitialWordNotEmpty(String? text) {
    bool isNotEmpty = text?.isNotEmpty ?? false;
    if (_isInitialWordNotEmpty != isNotEmpty) {
      setState(() {
        _isInitialWordNotEmpty = isNotEmpty;
      });
    }
  }

  @override
  Widget build(BuildContext context) => AppScaffold(
        appBarTitle: widget.folderName,
        drawer: const CustomDrawer(),
        onlyBottomWood: true,
        child: Column(
          children: [
            const Spacer(),
            TextFieldWidget(
              controller: _initialWordController,
              hintText: context.tr.translationWordDesc,
              onChanged: _updateInitialWordNotEmpty,
            ).animate().slideX().fade(),
            if (_isInitialWordNotEmpty)
              TextFieldWidget(
                suffixIcon: IconButton(
                  icon: const Icon(
                    Icons.auto_fix_high_outlined,
                    color: AppColors.daintree,
                  ),
                  onPressed: () {
                    //TODO: add auto translation
                  },
                ),
                controller: _translatedWordController,
                hintText: context.tr.translatedWordDesc,
              ).animate().slideX().fade(),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text(
                    context.tr.addWordFolderPage_addButtonText,
                    style: context.tht.displayMedium,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    context.tr.addWordFolderPage_finishButtonText,
                    style: context.tht.displayMedium,
                  ),
                ),
              ],
            ).animate(delay: 400.ms).slideX().fade(),
          ],
        ),
      );

  @override
  void dispose() {
    _translatedWordController.dispose();
    _initialWordController.dispose();
    super.dispose();
  }
}
