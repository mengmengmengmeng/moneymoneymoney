import 'package:injectable/injectable.dart';
import 'package:moneymoneymoney/data/datasources/user_remote_data_source.dart';
import 'package:moneymoneymoney/domain/entities/user.dart';
import 'package:moneymoneymoney/domain/repositories/user_repository.dart';

@LazySingleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});

  @override
  Future<User> login(String username, String password) {
    return remoteDataSource.login(username, password);
  }
}
