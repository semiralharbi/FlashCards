import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/entities/database/flashcard_entity.dart';
import '../../../../domain/entities/database/words_entity.dart';
import '../../../../domain/use_case/get_collections_use_case.dart';
import '../../../../domain/use_case/new_data_folder_use_case.dart';
import '../../../../domain/utils/failure.dart';
import 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._newDataFolderUseCase, this._getCollectionsUseCase)
      : super(const HomeState.initial(failure: Failure())) {
    init();
  }

  final NewDataFolderUseCase _newDataFolderUseCase;
  final GetCollectionsUseCase _getCollectionsUseCase;

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

  Future<void> createFolder({required String folderName}) async {
    final result = await _newDataFolderUseCase(
      FlashcardEntity(
        folderName: folderName,
        correctAnswers: 0,
        words: [
          const WordsEntity(enWord: 'enWord', translatedWord: 'translatedWord', nrRepeated: 0),
          const WordsEntity(enWord: 'ennWord', translatedWord: 'traanslatedWord', nrRepeated: 0),
          const WordsEntity(enWord: 'ennnWord', translatedWord: 'traaanslatedWord', nrRepeated: 0),
        ],
      ),
    );
    result.fold(
      (l) => l,
      (r) async => await init(),
    );
  }
}
