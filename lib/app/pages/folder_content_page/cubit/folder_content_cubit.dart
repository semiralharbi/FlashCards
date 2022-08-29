import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/entities/database/words_entity.dart';
import 'folder_content_state.dart';

@injectable
class FolderContentCubit extends Cubit<FolderContentState> {
  FolderContentCubit() : super(const FolderContentState.initial());

  void animate(AnimationController controller, ValueNotifier<bool> onChange) {
    if (controller.isAnimating == false) {
      if (controller.isCompleted) {
        controller.animateBack(0, duration: const Duration(milliseconds: 200));
        onChange.value = false;
      } else {
        controller.forward();
        onChange.value = true;
      }
    }
  }

  void nextPage(List<WordsEntity> entity) {
    const int index = 0;
    emit(FolderContentState.nextPage(entity, index));
    emit(const FolderContentState.initial());
  }
}
