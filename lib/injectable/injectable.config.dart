// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i11;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../app/pages/home_page/cubit/home_page_cubit.dart' as _i12;
import '../app/pages/registration_page/cubit/registration_page_cubit.dart'
    as _i13;
import '../app/theme/theme_manager.dart' as _i14;
import '../app/utils/router/app_router.gr.dart' as _i3;
import '../data/data_source/local/authentication_local_source_impl.dart' as _i5;
import '../data/data_source/remote/authentication_remote_source_impl.dart'
    as _i7;
import '../data/repositories/authentication_repo_impl.dart' as _i9;
import '../domain/data_source/local/authentication_local_source.dart' as _i4;
import '../domain/data_source/remote/authentication_remote_source.dart' as _i6;
import '../domain/repositories/authentication_repo.dart' as _i8;
import '../domain/use_case/create_user_use_case.dart' as _i10;
import 'modules/app_router_module.dart' as _i15;
import 'modules/flutter_secure_storage_module.dart'
    as _i16; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final appRouterModule = _$AppRouterModule();
  final flutterSecureStorageModule = _$FlutterSecureStorageModule();
  gh.lazySingleton<_i3.AppRouter>(() => appRouterModule.instance);
  gh.singleton<_i4.AuthenticationLocalSource>(
      _i5.AuthenticationLocalSourceImpl());
  gh.factory<_i6.AuthenticationRemoteSource>(
      () => _i7.AuthenticationRemoteSourceImpl());
  gh.factory<_i8.AuthenticationRepo>(
      () => _i9.AuthenticationRepoImpl(get<_i6.AuthenticationRemoteSource>()));
  gh.factory<_i10.CreateUserUseCase>(
      () => _i10.CreateUserUseCase(get<_i8.AuthenticationRepo>()));
  gh.lazySingleton<_i11.FlutterSecureStorage>(
      () => flutterSecureStorageModule.instance);
  gh.factory<_i12.HomePageCubit>(() => _i12.HomePageCubit());
  gh.factory<_i13.RegistrationPageCubit>(
      () => _i13.RegistrationPageCubit(get<_i10.CreateUserUseCase>()));
  gh.singleton<_i14.ThemeManager>(_i14.ThemeManager());
  return get;
}

class _$AppRouterModule extends _i15.AppRouterModule {}

class _$FlutterSecureStorageModule extends _i16.FlutterSecureStorageModule {}
