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

import 'data/datasources/transaction_remote_data_source.dart' as _i508;
import 'data/datasources/user_remote_data_source.dart' as _i379;
import 'data/repositories/transaction_repository_impl.dart' as _i991;
import 'data/repositories/user_repository_impl.dart' as _i1045;
import 'domain/repositories/transaction_repository.dart' as _i47;
import 'domain/repositories/user_repository.dart' as _i354;
import 'domain/usecases/get_transactions_usecase.dart' as _i1069;
import 'domain/usecases/login_usecase.dart' as _i883;
import 'domain/usecases/send_money_usecase.dart' as _i760;
import 'injection_module.dart' as _i212;
import 'ui/bloc/login/login_bloc.dart' as _i266;
import 'ui/bloc/send_money/send_money_bloc.dart' as _i412;
import 'ui/bloc/transaction_history/transaction_history_bloc.dart' as _i720;

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
  gh.factory<_i508.TransactionRemoteDataSource>(
    () => _i508.TransactionRemoteDataSourceImpl(client: gh<_i519.Client>()),
  );
  gh.factory<_i47.TransactionRepository>(
    () => _i991.TransactionRepositoryImpl(
      remoteDataSource: gh<_i508.TransactionRemoteDataSource>(),
    ),
  );
  gh.factory<_i760.SendMoneyUseCase>(
    () => _i760.SendMoneyUseCase(gh<_i47.TransactionRepository>()),
  );
  gh.factory<_i412.SendMoneyBloc>(
    () => _i412.SendMoneyBloc(gh<_i760.SendMoneyUseCase>()),
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
  gh.factory<_i1069.GetTransactionsUseCase>(
    () => _i1069.GetTransactionsUseCase(gh<_i47.TransactionRepository>()),
  );
  gh.factory<_i720.TransactionHistoryBloc>(
    () => _i720.TransactionHistoryBloc(gh<_i1069.GetTransactionsUseCase>()),
  );
  return getIt;
}

class _$InjectionModule extends _i212.InjectionModule {}
