import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/entities/database/words_entity.dart';
import 'flashcard_state.dart';

@injectable
class FlashcardCubit extends Cubit<FlashcardState> {
  FlashcardCubit() : super(const FlashcardState.initial());

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
    required List<WordsEntity> entity,
    required AnimationController controller,
    required int index,
    required bool isCorrect,
  }) async {
    if (controller.isDismissed) {
      await controller.forward(from: 0.0);
      await Future.delayed(
        const Duration(milliseconds: 600),
      );
    }
    if (index < entity.length - 1) {
      index++;
      emit(FlashcardState.next(entity, index));
    } else {
      emit(const FlashcardState.results());
    }
  }
}
