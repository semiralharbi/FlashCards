// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../app/theme/theme_manager.dart' as _i5;
import '../app/utils/router/app_router.gr.dart' as _i3;
import 'modules/app_router_module.dart' as _i6;
import 'modules/flutter_secure_storage_module.dart'
    as _i7; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final appRouterModule = _$AppRouterModule();
  final flutterSecureStorageModule = _$FlutterSecureStorageModule();
  gh.lazySingleton<_i3.AppRouter>(() => appRouterModule.instance);
  gh.lazySingleton<_i4.FlutterSecureStorage>(
      () => flutterSecureStorageModule.instance);
  gh.singleton<_i5.ThemeManager>(_i5.ThemeManager());
  return get;
}

class _$AppRouterModule extends _i6.AppRouterModule {}

class _$FlutterSecureStorageModule extends _i7.FlutterSecureStorageModule {}
