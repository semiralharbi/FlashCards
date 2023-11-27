import '../../../../domain/entities/database/folder_entity.dart';
import '../../../theme/global_imports.dart';
import '../../../widgets/alphabet_container.dart';

class AlphabetLetters extends StatefulWidget {
  const AlphabetLetters({
    super.key,
    required this.folders,
    required this.controller,
  });

  final List<FolderEntity> folders;
  final ScrollController controller;

  @override
  State<AlphabetLetters> createState() => _AlphabetLettersWidgetState();
}

class _AlphabetLettersWidgetState extends State<AlphabetLetters> {
  String currentLetter = 'A';
  List<String> letters = [];

  @override
  void initState() {
    super.initState();

    if (widget.folders.isNotEmpty) {
      letters = widget.folders.map((e) => e.folderName[0].toUpperCase()).toSet().toList();
      widget.controller.addListener(_scrollListener);
    } else {
      letters = [];
    }
  }

  void _scrollListener() {
    double position = widget.controller.offset / AppDimensions.d86;
    int index = position.floor();
    if (index >= 0 && index < widget.folders.length) {
      final letter = widget.folders[index].folderName[0].toUpperCase();
      if (letter != currentLetter) {
        setState(() {
          currentLetter = letter;
        });
      }
    }
  }

  void _jumpToFolder(int index) {
    int value = 0;
    for (int i = 0; i < widget.folders.length; i++) {
      if (widget.folders[i].folderName[0].toUpperCase() == letters[index]) {
        value = i;
        break;
      }
    }
    widget.controller.jumpTo(value * AppDimensions.d86);
    currentLetter = letters[index];
  }

  @override
  Widget build(BuildContext context) => ListView.builder(
        physics: const ClampingScrollPhysics(),
        itemCount: letters.length,
        itemBuilder: (context, index) => AlphabetContainer(
          onPressed: () => _jumpToFolder(index),
          isSelectedLetter: letters[index] == currentLetter,
          text: letters[index],
        ),
      );

  @override
  void dispose() {
    widget.controller.removeListener(_scrollListener);
    super.dispose();
  }
}
