import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/entities/database/folder_entity.dart';
import '../../../../domain/entities/database/words_entity.dart';
import '../../../../domain/use_case/update_folder_data.dart';
import 'flashcard_state.dart';

@injectable
class FlashcardCubit extends Cubit<FlashcardState> {
  FlashcardCubit(this._updateFolderDataUseCase) : super(const FlashcardState.initial());

  final UpdateFolderDataUseCase _updateFolderDataUseCase;
  bool isLastWord = false;

  void animate(AnimationController controller) {
    if (controller.isAnimating == false) {
      if (controller.isCompleted) {
        controller.reverse();
      } else {
        controller.forward(from: 0.0);
      }
    }
  }

  Future<void> next({
    required FolderEntity entity,
    required AnimationController controller,
    required int index,
    required bool isCorrect,
    List<WordsEntity>? newEntityList,
  }) async {
    if (controller.isDismissed && !controller.isAnimating) {
      await controller.forward(from: 0.0);
      await Future.delayed(
        const Duration(milliseconds: 250),
      );
    }
    List<WordsEntity> wordsList = newEntityList?.toList() ?? entity.words.toList();
    if (!isLastWord) {
      wordsList[index] =
          entity.words[index].copyWith(correctAnswer: isCorrect, nrRepeated: wordsList[index].nrRepeated + 1);
    }
    if (index < entity.words.length - 1) {
      index++;
      emit(FlashcardState.next(wordsList, index));
    } else {
      isLastWord = true;
      int correctAnswersCounter = 0;
      for (final correctAnswer in wordsList) {
        if (correctAnswer.correctAnswer == true) {
          correctAnswersCounter++;
        }
      }
      final newEntity = entity.copyWith(
        words: wordsList,
        correctAnswers: correctAnswersCounter,
      );
      await _updateFolderDataUseCase(newEntity);
      emit(FlashcardState.results(newEntity));
    }
  }
}
