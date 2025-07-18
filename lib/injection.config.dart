// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:http/http.dart' as _i519;
import 'package:injectable/injectable.dart' as _i526;

import 'data/datasources/user_remote_data_source.dart' as _i379;
import 'data/repositories/user_repository_impl.dart' as _i1045;
import 'domain/repositories/user_repository.dart' as _i354;
import 'domain/usecases/login_usecase.dart' as _i883;
import 'injection_module.dart' as _i212;
import 'ui/bloc/login/login_bloc.dart' as _i266;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  final injectionModule = _$InjectionModule();
  gh.lazySingleton<_i519.Client>(() => injectionModule.client);
  gh.lazySingleton<_i379.UserRemoteDataSource>(
    () => _i379.UserRemoteDataSourceImpl(client: gh<_i519.Client>()),
  );
  gh.lazySingleton<_i354.UserRepository>(
    () => _i1045.UserRepositoryImpl(
      remoteDataSource: gh<_i379.UserRemoteDataSource>(),
    ),
  );
  gh.factory<_i883.LoginUseCase>(
    () => _i883.LoginUseCase(gh<_i354.UserRepository>()),
  );
  gh.factory<_i266.LoginBloc>(() => _i266.LoginBloc(gh<_i883.LoginUseCase>()));
  return getIt;
}

class _$InjectionModule extends _i212.InjectionModule {}
