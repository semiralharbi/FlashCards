import 'package:injectable/injectable.dart';

import '../../../../domain/entities/database/folder_entity.dart';
import '../../../../domain/use_case/delete_word_use_case.dart' as delete_word;
import '../../../../domain/use_case/get_folders_use_case.dart';
import '../../../theme/global_imports.dart';
import 'folder_content_state.dart';

@injectable
class FolderContentCubit extends Cubit<FolderContentState> {
  FolderContentCubit(
    this._deleteWordUseCase,
    this._getCollectionsUseCase,
  ) : super(const FolderContentState.initial());

  final delete_word.DeleteWordUseCase _deleteWordUseCase;
  final GetFoldersUseCase _getCollectionsUseCase;

  Future<void> init(FolderEntity entity) async {
    final result = await _getCollectionsUseCase();
    result.fold(
      //TODO:Implement Error
      (l) => null,
      (r) => emit(
        FolderContentState.loaded(
          r.firstWhere((element) => element.folderName == entity.folderName),
        ),
      ),
    );
  }

  Future<void> deleteWord(FolderEntity entity, int index) async {
    final result = await _deleteWordUseCase(delete_word.Params(index, entity));
    result.fold(
      //TODO: Implement error
      (l) => l,
      (r) => init(entity),
    );
  }

  void nextPage(FolderEntity entity) {
    const int index = 0;
    emit(FolderContentState.nextPage(entity, index));
    emit(const FolderContentState.initial());
  }
}
