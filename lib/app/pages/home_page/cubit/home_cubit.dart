import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/entities/database/flashcard_entity.dart';
import '../../../../domain/use_case/delete_folder_use_case.dart';
import '../../../../domain/use_case/get_collections_use_case.dart';
import '../../../utils/enums/errors.dart';
import 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  HomeCubit(
    this._getCollectionsUseCase,
    this._deleteFolderDataUseCase,
  ) : super(const HomeState.initial());

  final GetCollectionsUseCase _getCollectionsUseCase;
  final DeleteFolderDataUseCase _deleteFolderDataUseCase;

  Future<void> init() async {
    emit(const HomeState.loading());
    final result = await _getCollectionsUseCase();
    result.fold(
      (l) => emit(HomeState.initial(failure: l)),
      (r) => emit(HomeState.initial(entity: r)),
    );
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut().then(
          (value) => emit(const HomeState.logout()),
        );
  }

  Future<void> deleteFolder(FlashcardEntity entity) async {
    final result = await _deleteFolderDataUseCase(entity);
    result.fold(
      (l) => emit(HomeState.fail(l.appError ?? Errors.unknownError)),
      (r) async => await init(),
    );
  }
}
