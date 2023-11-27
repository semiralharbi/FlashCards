import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/entities/database/folder_entity.dart';
import '../../../../domain/use_case/delete_folder_use_case.dart';
import '../../../../domain/use_case/get_folders_use_case.dart';
import '../../../../domain/use_case/sign_out_use_case.dart';
import 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  HomeCubit(
    this._getFoldersUseCase,
    this._deleteFolderDataUseCase,
    this._singOutUseCase,
  ) : super(const HomeState.loading()) {
    fetchFolders();
  }

  final GetFoldersUseCase _getFoldersUseCase;
  final DeleteFolderDataUseCase _deleteFolderDataUseCase;
  final SingOutUseCase _singOutUseCase;

  Future<void> fetchFolders() async {
    final result = await _getFoldersUseCase();
    result.fold(
      (l) => emit(HomeState.empty(failure: l.error)),
      (folders) => emit(HomeState.loaded(folders: folders)),
    );
  }

  Future<void> logout() async {
    final result = await _singOutUseCase();
    result.fold(
      (l) => emit(HomeState.fail(l.error)),
      (r) => emit(const HomeState.logout()),
    );
  }

  Future<void> deleteFolder(FolderEntity entity) async {
    final result = await _deleteFolderDataUseCase(entity);
    result.fold(
      (l) => emit(HomeState.fail(l.error)),
      (r) async => await fetchFolders(),
    );
  }
}
