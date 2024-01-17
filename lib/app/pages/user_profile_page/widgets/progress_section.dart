import '../../../theme/global_imports.dart';
import '../../../widgets/progress_conrainer.dart';
import 'category_text.dart';

class ProgressSection extends StatelessWidget {
  const ProgressSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDimensions.d20),
      child: Column(
        children: [
          CategoryTextWidget(
            categoryText: context.tr.userProfilePage_yourProgress,
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //TODO: CHANGE THE HARDCODED VALUES
              ProgressContainer(
                information: context.tr.userProfilePage_progressContainer_foldersDone,
                progress: 10,
              ),
              ProgressContainer(
                information: context.tr.userProfilePage_progressContainer_percentProgress,
                progress: 7,
              ),
              ProgressContainer(
                information: context.tr.userProfilePage_progressContainer_wordsCreated,
                progress: 1000,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
