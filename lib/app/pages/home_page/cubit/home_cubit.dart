import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/entities/database/flashcard_entity.dart';
import '../../../../domain/entities/database/words_entity.dart';
import '../../../../domain/use_case/delete_folder_use_case.dart';
import '../../../../domain/use_case/get_collections_use_case.dart';
import '../../../../domain/use_case/new_data_folder_use_case.dart';
import '../../../../domain/utils/failure.dart';
import 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  HomeCubit(
    this._newDataFolderUseCase,
    this._getCollectionsUseCase,
    this._deleteFolderDataUseCase,
  ) : super(const HomeState.initial(failure: Failure())) {
    init();
  }

  final NewDataFolderUseCase _newDataFolderUseCase;
  final GetCollectionsUseCase _getCollectionsUseCase;
  final DeleteFolderDataUseCase _deleteFolderDataUseCase;

  Future<void> init() async {
    final result = await _getCollectionsUseCase();
    result.fold(
      (l) => emit(
        HomeState.initial(failure: l),
      ),
      (r) => emit(
        HomeState.initial(
          entity: r,
        ),
      ),
    );
  }

  Future<void> deleteFolder(FlashcardEntity entity) async {
    final result = await _deleteFolderDataUseCase(entity);
    result.fold(
      //TODO: Implement error
      (l) => null,
      (r) async => await init(),
    );
  }

  Future<void> createFolder({
    required String folderName,
    required List<String> enWordsList,
    required List<String> translatedWordsList,
  }) async {
    List<WordsEntity> wordsEntityList = [];
    for (int i = 0; i <= translatedWordsList.length - 1; i++) {
      if (enWordsList[i].isNotEmpty && translatedWordsList[i].isNotEmpty) {
        WordsEntity wordsEntity = WordsEntity(
          enWord: enWordsList[i],
          translatedWord: translatedWordsList[i],
          nrRepeated: 0,
        );
        wordsEntityList.add(wordsEntity);
      }
    }
    final result = await _newDataFolderUseCase(
      FlashcardEntity(
        folderName: folderName,
        correctAnswers: 0,
        words: wordsEntityList,
      ),
    );
    result.fold(
      (l) => l,
      (r) async => await init(),
    );
  }
}
