import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/entities/database/flashcard_entity.dart';
import '../../../../domain/entities/database/words_entity.dart';
import '../../../../domain/use_case/update_folder_data.dart';
import 'flashcard_state.dart';

@injectable
class FlashcardCubit extends Cubit<FlashcardState> {
  FlashcardCubit(this._updateFolderDataUseCase) : super(const FlashcardState.initial());

  final UpdateFolderDataUseCase _updateFolderDataUseCase;
  List<WordsEntity> newEntityList = [];
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
    required FlashcardEntity entity,
    required AnimationController controller,
    required int index,
    required bool isCorrect,
  }) async {
    if (controller.isDismissed) {
      await controller.forward(from: 0.0);
      await Future.delayed(
        const Duration(milliseconds: 250),
      );
    }
    newEntityList = entity.words;
    if (!isLastWord) {
      final wordElement = entity.words[index].copyWith(
        correctAnswer: isCorrect,
        nrRepeated: entity.words[index].nrRepeated + 1,
      );
      newEntityList[index] = wordElement;
    }
    if (index < entity.words.length - 1) {
      index++;
      emit(FlashcardState.next(newEntityList, index));
    } else {
      isLastWord = true;
      entity = entity.copyWith(words: newEntityList);
      await _updateFolderDataUseCase(entity);
      emit(const FlashcardState.results());
    }
  }
}
