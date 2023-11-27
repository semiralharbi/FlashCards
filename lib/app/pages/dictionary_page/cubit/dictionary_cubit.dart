import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/use_case/get_word_info_use_case.dart';
import 'dictionary_state.dart';

@injectable
class DictionaryCubit extends Cubit<DictionaryState> {
  DictionaryCubit(this._getWordInfoUseCase) : super(const DictionaryState.initial());

  final GetWordInfoUseCase _getWordInfoUseCase;

  Future<void> searchWord(String word) async {
    emit(const DictionaryState.loading());
    final result = await _getWordInfoUseCase(word);
    result.fold(
      (l) => emit(DictionaryState.failure(l.error)),
      (r) => emit(DictionaryState.success(r)),
    );
  }
}
