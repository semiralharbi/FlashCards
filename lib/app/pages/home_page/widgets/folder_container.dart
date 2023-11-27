import '../../../../domain/entities/database/folder_entity.dart';
import '../../../theme/global_imports.dart';
import '../../../utils/enums/string_extensions.dart';
import 'dismissible_background.dart';
import 'folder_list_tile.dart';
import 'language_flags_box.dart';
import 'words_match_progress_bar.dart';

class FolderContainer extends StatelessWidget {
  const FolderContainer({
    super.key,
    this.onTap,
    required this.folder,
    required this.onDismissed,
  });

  final VoidCallback? onTap;
  final FolderEntity folder;
  final Function(DismissDirection) onDismissed;

  @override
  Widget build(BuildContext context) {
    final double percent = (folder.correctAnswers ?? 0) / folder.words.length;

    return GestureDetector(
      onTap: onTap,
      child: FolderListTile(
        child: Dismissible(
          onDismissed: onDismissed,
          direction: DismissDirection.endToStart,
          key: key!,
          background: const DismissibleBackground(),
          child: Padding(
            padding: const EdgeInsets.all(AppDimensions.d10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const LanguageFlagsBox(),
                Container(
                  constraints: const BoxConstraints(maxWidth: AppDimensions.d146),
                  child: Text(
                    folder.folderName.capitalize(),
                    style: context.tht.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: AppDimensions.d16,
                      color: AppColors.daintree,
                    ),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
                WordsMatchProgressBar(
                  hasWords: folder.words.isNotEmpty,
                  percent: percent,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
