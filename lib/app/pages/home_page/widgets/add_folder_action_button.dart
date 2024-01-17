import '../../../theme/global_imports.dart';
import '../../../widgets/app_floating_action_button.dart';
import '../../../widgets/custom_create_folder_dialog.dart';

class AddFolderActionButton extends StatefulWidget {
  const AddFolderActionButton({super.key});

  @override
  State<AddFolderActionButton> createState() => _AddFolderActionButtonState();
}

class _AddFolderActionButtonState extends State<AddFolderActionButton> {
  late final TextEditingController folderController;
  final IconData icon = Icons.add;

  @override
  void initState() {
    super.initState();
    folderController = TextEditingController();
  }

  Future<void> _onFloatingActionButtonTapped() async {
    final bool createFolder = await showDialog<bool>(
          useSafeArea: false,
          context: context,
          builder: (_) => CreateFolderDialog(controller: folderController),
        ) ??
        false;
    if (createFolder && mounted) {
      context.router.push(CreateFolderRoute(folderName: folderController.text));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppFloatingActionButton(
      onPressed: _onFloatingActionButtonTapped,
      icon: icon,
    );
  }
}
